library(plyr)

# Function to read a single email message's headers from a file.
# Adapted from Conway, White: Machine Learning for Hackers
get.message.headers  <- function(path){
  tryCatch({
    con <- file(path, open="rt", encoding="ascii")
    text <- readLines(con)
    # Headers of an email end with the first empty line in the file.
    headers <- text[seq(1,which(text=="")[1]-1, 1)]
    close(con)
    return(headers)
  },
  error = function(e){
    # Return NA if there was an error. A proper script would need error handling here.
    return(NA)
  })
}

# This function extracts the "To:" and "From:" fields from email headers.
parse.message <- function(headers){
  if(is.na(headers)){
    return(matrix(c(NA, NA, NA, NA, NA), nrow = 5, byrow = T))
  }
  
  date <- grep("^Date:",headers,ignore.case=TRUE,value=TRUE)[1]
  # Just keep the email address without the Date: field
  date <- sub("^Date:\\s*", "", date, ignore.case=TRUE)
  
  content_type <- grep("^Content-Type:",headers,ignore.case=TRUE,value=TRUE)[1]
  # Just keep the email address without the Date: field
  content_type <- sub("^Content-Type: text/\\s*", "", content_type, ignore.case=TRUE)
  content_type <- unlist(strsplit(content_type, split="; *"))
  content_type <- content_type[1]
  
  from <- grep("^From:",headers,ignore.case=TRUE,value=TRUE)[1]
  # Just keep the email address without the From: field
  from <- sub("^From:\\s*", "", from, ignore.case=TRUE) 
  
  to <- grep("^to:",headers,ignore.case=TRUE,value=TRUE)[1]
  # Just keep the email address without the To: field
  to <- sub("^to:\\s*", "", to, ignore.case=TRUE)
  
  cc <- grep("^cc:",headers,ignore.case=TRUE,value=TRUE)[1]
  # Just keep the email address without the Cc: field
  cc <- sub("^cc:\\s*", "", cc, ignore.case=TRUE)
  # 
  to  <- unlist(strsplit(to , split="[,;] *"))
  cc  <- unlist(strsplit(cc , split="[,;] *"))
  
  a <- c(to, cc)
  b <- rep("to",length(to))
  b <- c(b, rep("cc",length(cc)))
  # 
  maxim <- length(a)
  # 
  from <- rep(from,maxim)
  content_type  <- rep(content_type,maxim)
  date  <- rep(date,maxim)
  
  # if(!is.na(bcc)){
  #   if(regexpr(",",bcc,fixed=TRUE)[1] != -1){
  #     bcc <- NA
  #   }
  # }
  return(matrix(c(from, a, b, content_type, date), nrow = 5, byrow = T))
}

# Get all 'Sent' folders from the mailboxes contained in the dataset
mail_folders <- file("script/sent_folders", open="rt", encoding="ascii")
mail_files_paths <- readLines(mail_folders)
close(mail_folders)

# Construct paths for all files contained in the above folders
mail_files <- unlist(lapply(mail_files_paths, function(path){
  paste(path, dir(path), sep="/")
}))
# Read and parse all mails (this step takes time)
mails_tmp <- lapply(mail_files, function(filename){ 
  parse.message(get.message.headers(filename))
})

mails_from <- unlist(lapply(mails_tmp, function(x) { x[1,] }))
mails_to   <- unlist(lapply(mails_tmp, function(x) { x[2,] }))
mails_cc   <- unlist(lapply(mails_tmp, function(x) { x[3,] }))
mails_content   <- unlist(lapply(mails_tmp, function(x) { x[4,] }))
mails_date   <- unlist(lapply(mails_tmp, function(x) { x[5,] }))
lct   <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
mails_date <- as.character.Date(strptime(mails_date,  "%a, %d %b %Y %H:%M:%S %z"))

mails <- na.omit(data.frame(sub("@enron.com>?", "", mails_from),
                    sub("@enron.com>?", "", mails_to),
                    mails_cc,
                    mails_content,
                    mails_date))
colnames(mails) <- c("From", "To", "Cc", "Content", "Date")

# Turn mail data into an R data frame, removing cases that could not be parsed above.
# lct   <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
# dates <- as.character.Date(strptime(mails_tmp[5,],  "%a, %d %b %Y %H:%M:%S %z"))
# mails <- na.omit(data.frame(sub("@enron.com>?", "", mails_tmp[1,]),
#                             sub("@enron.com>?", "", mails_tmp[2,]), 
#                             sub(".*@", "", mails_tmp[1,]),
#                             sub(".*@", "", mails_tmp[2,]),
#                             sub("@enron.com>?", "", mails_tmp[3,]), 
#                             sub(".*@", "", mails_tmp[3,]),
#                             sub("@enron.com>?", "", mails_tmp[4,]), 
#                             sub(".*@", "", mails_tmp[4,]),
#                             dates, 
#                             mails_tmp[6,]))
# colnames(mails) <- c("From", "To", "DomainFrom", "DomainTo", "Cc", "DomainCc", "Bcc", "DomainBcc", "Date", "Content_Type")

# mails[,7] <- sub(".*@", "", mails$From)
# mails[,8] <- sub(".*@", "", mails$To)
# mails$From <- sub("@enron.com", "",mails$From)
# mails$To <- sub("@enron.com", "",mails$To)
# 
# tmp1 <- mails[,3]
# tmp2 <- mails[,4]
# mails[,3] <- mails[,7]
# mails[,4] <- mails[,8]
# mails[,7] <- tmp1
# mails[,8] <- tmp2
# colnames(mails) <- c("From", "To", "DomainFrom", "DomainTo","Date", "Content_Type")

#########################################################################
# Commented out useful commands:

# Reduce duplicate entries to one entry, but count the number of occurences
mails.counted <- ddply(mails, .(From, To, Cc, Content, Date), summarise, weight = length(To))
mails.sender <- unique(mails.counted$From)
mails.connected <- subset(mails.counted, To %in% mails.sender)

top.10 <- mails.connected[order(mails.connected$weight, decreasing=TRUE),][1:10,]
top.20 <- mails.connected[order(mails.connected$weight, decreasing=TRUE),][1:20,]
top.100 <- mails.connected[order(mails.connected$weight, decreasing=TRUE),][1:100,]
more.than.50 <- subset(mails.connected, weight > 100)
!is.na(match(mails.counted$To, mails.sender))




#arcplot(as.matrix(mails.counted)[1:17,1:2])
#arcplot(as.matrix(mails.connected)[,1:2], lwd.arcs = log(mails.connected$count)+1)
#arcplot(as.matrix(top.ten[,1:2]), cex.labels = 0.5,
#        lwd.arcs = log(top.ten$count)+1, pch.nodes = 21, lwd.nodes = 2, line = 0, cex.nodes = top.ten$count*0.001)



#
# cohesive <- cohesive.blocks(friend.g)
# cohesive
# length(cohesive)
# plot(cohesive, friend.g, vertex.label=NA)
#
# clique <- cliques(friend.g, min=4)
# clique.graph <- induced.subgraph(graph=friend.g,vids=clique[[1]])
# plot(clique.graph)




