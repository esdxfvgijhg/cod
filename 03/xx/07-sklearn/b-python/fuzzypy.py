# Fuzzy Logic experiment (WIP)
# Objects are not always in one of two states (true or false), but rather in several states at one time. # By the Tutorial Doctor
# --------------------------------------------------------------------------- # (val-min)/(max-min)
# ------------------------------------------------------------------------------ # VARIABLES
cold = (1, 213)
hot = (3, 94)
funny = (90, 100)
close = (0, 5)
joes_distance = 7
joes_funniness = 97
sam = 0
San_Antonio = 100
Georgia = 99
# FUNCTIONS # ------------------------------------------------------------------------------
def GetFuzzyValues(List, Label):  # ------------------------------------------------------------------------------
    "Prints the membership of every value between the values of a 2-tuple"
    for i in range(List[0], List[-1] + 1):  # For every item in the range of a list...
        # Print a lanel for the lis also # print the item and the membership of the item in the list.
        print str(i) + " is " + str((float(i) - List[0]) / (List[-1] - List[0])) + " " + Label


def Membership(x, List):
    "Returns the membership of a value in a list."
    top = float(x) - List[0]
    bottom = List[-1] - List[0]
    M = top / bottom
    if M > 0.666:
        ml = 3
    if M < 0.333:
        ml = 1
    if M < 0.666 and M > 0.333:
        ml = 2
    return ml


def Is(x, List):
    "Returns true if a value is in the value range of a list"
    ml = 0
    if x >= List[0]:  # If a value is greater than the first item in a list..
        if x <= List[-1]:  # And if it is smaller than the last item in the list...
            ml = Membership(x, List)  # print the membership of the item in the list...
    # 			return True # And return True
    # Print the membership and return False if the above condition is false. # No else statement is needed since the return statement will exit the function.
    return ml  # 	print Membership(x,List)


def Get(List, x, i=0):
    steps = 0
    while x <= List[1]:
        print (x, Membership(x, List))
        x = x + i
        print "steps: {}".format(steps)
        steps = steps + 1


def document(f):
    print f.__name__ + ": " + f.__doc__ + "\n"  # Print the name of a function and its document string.


# USAGE # ------------------------------------------------------------------------------
print Is(208.14, cold)  # ------------------------------------------------------------------------------
print Is(92, hot)
print Is(joes_funniness, funny)
print Is(joes_distance, close)
print Is(joes_distance, cold)
print Is(joes_funniness, hot)  # print
# Get(close,sam,.1) # print
print (Is(Georgia, hot))
# How to interpret this membership? # print
# DOCUMENTATION # ------------------------------------------------------------------------------
# document(Is) # ------------------------------------------------------------------------------
# document(GetFuzzyValues) # document(Membership)
# ------------------------------------------------------------------------------
