
#include "arduPi_pi2.h"
struct bcm2835_peripheral gpio = {GPIO_BASE2};
struct bcm2835_peripheral bsc_rev1 = {IOBASE + 0X205000};
struct bcm2835_peripheral bsc_rev2 = {IOBASE + 0X804000};
struct bcm2835_peripheral bsc0;
volatile uint32_t *bcm2835_bsc01;
void *spi0 = MAP_FAILED;
static uint8_t *spi0Mem = NULL;
pthread_t idThread2;
pthread_t idThread3;
pthread_t idThread4;
pthread_t idThread5;
pthread_t idThread6;
pthread_t idThread7;
pthread_t idThread8;
pthread_t idThread9;
pthread_t idThread10;
pthread_t idThread11;
pthread_t idThread12;
pthread_t idThread13;
timeval start_program, end_point;
SerialPi::SerialPi() {
  REV = getBoardRev();
  serialPort = "/dev/ttyAMA0";
  timeOut = 1000;
}
void SerialPi::begin(int serialSpeed) {
  switch (serialSpeed) {
  case 50:
    speed = B50;
    break;
  case 75:
    speed = B75;
    break;
  case 110:
    speed = B110;
    break;
  case 134:
    speed = B134;
    break;
  case 150:
    speed = B150;
    break;
  case 200:
    speed = B200;
    break;
  case 300:
    speed = B300;
    break;
  case 600:
    speed = B600;
    break;
  case 1200:
    speed = B1200;
    break;
  case 1800:
    speed = B1800;
    break;
  case 2400:
    speed = B2400;
    break;
  case 9600:
    speed = B9600;
    break;
  case 19200:
    speed = B19200;
    break;
  case 38400:
    speed = B38400;
    break;
  case 57600:
    speed = B57600;
    break;
  case 115200:
    speed = B115200;
    break;
  default:
    speed = B230400;
    break;
  }
  if ((sd = open(serialPort, O_RDWR | O_NOCTTY | O_NDELAY | O_NONBLOCK)) == -1) {
    fprintf(stderr, "Unable to open the serial port %s - \n", serialPort);
    exit(-1);
  }
  fcntl(sd, F_SETFL, O_RDWR);
  tcgetattr(sd, &options);
  cfmakeraw(&options);
  cfsetispeed(&options, speed);
  cfsetospeed(&options, speed);
  options.c_cflag |= (CLOCAL | CREAD);
  options.c_cflag &= ~PARENB;
  options.c_cflag &= ~CSTOPB;
  options.c_cflag &= ~CSIZE;
  options.c_cflag |= CS8;
  options.c_lflag &= ~(ICANON | ECHO | ECHOE | ISIG);
  options.c_oflag &= ~OPOST;
  tcsetattr(sd, TCSANOW, &options);
  ioctl(sd, TIOCMGET, &status);
  status |= TIOCM_DTR;
  status |= TIOCM_RTS;
  ioctl(sd, TIOCMSET, &status);
  unistd::usleep(10000);
}
void SerialPi::print(const char *message) { unistd::write(sd, message, strlen(message)); }
void SerialPi::print(char message) { unistd::write(sd, &message, 1); }
void SerialPi::print(unsigned char i, Representation rep) {
  char *message;
  switch (rep) {
  case BIN:
    message = int2bin(i);
    unistd::write(sd, message, strlen(message));
    break;
  case OCT:
    message = int2oct(i);
    unistd::write(sd, message, strlen(message));
    break;
  case DEC:
    sprintf(message, "%d", i);
    unistd::write(sd, message, strlen(message));
    break;
  case HEX:
    message = int2hex(i);
    unistd::write(sd, message, strlen(message));
    break;
  case BYTE:
    unistd::write(sd, &i, 1);
    break;
  }
}
void SerialPi::print(float f, int precission) {
  char message[10];
  sprintf(message, "%.1f", f);
  unistd::write(sd, message, strlen(message));
}
void SerialPi::println(const char *message) {
  const char *newline = "\r\n";
  char *msg = NULL;
  asprintf(&msg, "%s%s", message, newline);
  unistd::write(sd, msg, strlen(msg));
}
void SerialPi::println(char message) {
  const char *newline = "\r\n";
  char *msg = NULL;
  asprintf(&msg, "%s%s", &message, newline);
  unistd::write(sd, msg, strlen(msg));
}
void SerialPi::println(int i, Representation rep) {
  char *message;
  switch (rep) {
  case BIN:
    message = int2bin(i);
    break;
  case OCT:
    message = int2oct(i);
    break;
  case DEC:
    sprintf(message, "%d", i);
    break;
  case HEX:
    message = int2hex(i);
    break;
  }
  const char *newline = "\r\n";
  char *msg = NULL;
  asprintf(&msg, "%s%s", message, newline);
  unistd::write(sd, msg, strlen(msg));
}
void SerialPi::println(float f, int precission) {
  const char *str1 = "%.";
  char *str2;
  char *str3;
  char *message;
  sprintf(str2, "%df", precission);
  asprintf(&str3, "%s%s", str1, str2);
  sprintf(message, str3, f);
  const char *newline = "\r\n";
  char *msg = NULL;
  asprintf(&msg, "%s%s", message, newline);
  unistd::write(sd, msg, strlen(msg));
}
int SerialPi::write(unsigned char message) {
  unistd::write(sd, &message, 1);
  return 1;
}
int SerialPi::write(const char *message) {
  int len = strlen(message);
  unistd::write(sd, &message, len);
  return len;
}
int SerialPi::write(char *message, int size) {
  unistd::write(sd, message, size);
  return size;
}
int SerialPi::available() {
  int nbytes = 0;
  if (ioctl(sd, FIONREAD, &nbytes) < 0) {
    fprintf(stderr, "Failed to get byte count on serial.\n");
    exit(-1);
  }
  return nbytes;
}
char SerialPi::read() {
  unistd::read(sd, &c, 1);
  return c;
}
int SerialPi::readBytes(char message[], int size) {
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
  int count;
  for (count = 0; count < size; count++) {
    if (available())
      unistd::read(sd, &message[count], 1);
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    timespec t = timeDiff(time1, time2);
    if ((t.tv_nsec / 1000) > timeOut)
      break;
  }
  return count;
}
int SerialPi::readBytesUntil(char character, char buffer[], int length) {
  char lastReaded = character + 1;
  int count = 0;
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
  while (count != length && lastReaded != character) {
    if (available())
      unistd::read(sd, &buffer[count], 1);
    lastReaded = buffer[count];
    count++;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    timespec t = timeDiff(time1, time2);
    if ((t.tv_nsec / 1000) > timeOut)
      break;
  }
  return count;
}
bool SerialPi::find(const char *target) { findUntil(target, NULL); }
bool SerialPi::findUntil(const char *target, const char *terminal) {
  int index = 0;
  int termIndex = 0;
  int targetLen = strlen(target);
  int termLen = strlen(terminal);
  char readed;
  timespec t;
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
  if (*target == 0)
    return true;
  do {
    if (available()) {
      unistd::read(sd, &readed, 1);
      if (readed != target[index])
        index = 0;
      if (readed == target[index]) {
        if (++index >= targetLen) {
          return true;
        }
      }
      if (termLen > 0 && c == terminal[termIndex]) {
        if (++termIndex >= termLen)
          return false;
      } else {
        termIndex = 0;
      }
    }
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    t = timeDiff(time1, time2);
  } while ((t.tv_nsec / 1000) <= timeOut);
  return false;
}
long SerialPi::parseInt() {
  bool isNegative = false;
  long value = 0;
  char c;
  do {
    c = peek();
    if (c == '-')
      break;
    if (c >= '0' && c <= '9')
      break;
    unistd::read(sd, &c, 1);
  } while (1);
  do {
    if (c == '-')
      isNegative = true;
    else if (c >= '0' && c <= '9')
      value = value * 10 + c - '0';
    unistd::read(sd, &c, 1);
    c = peek();
  } while (c >= '0' && c <= '9');
  if (isNegative)
    value = -value;
  return value;
}
float SerialPi::parseFloat() {
  boolean isNegative = false;
  boolean isFraction = false;
  long value = 0;
  char c;
  float fraction = 1.0;
  do {
    c = peek();
    if (c == '-')
      break;
    if (c >= '0' && c <= '9')
      break;
    unistd::read(sd, &c, 1);
  } while (1);
  do {
    if (c == '-')
      isNegative = true;
    else if (c == '.')
      isFraction = true;
    else if (c >= '0' && c <= '9') {
      value = value * 10 + c - '0';
      if (isFraction)
        fraction *= 0.1;
    }
    unistd::read(sd, &c, 1);
    c = peek();
  } while ((c >= '0' && c <= '9') || (c == '.' && isFraction == false));
  if (isNegative)
    value = -value;
  if (isFraction)
    return value * fraction;
  else
    return value;
}
char SerialPi::peek() {
  FILE *f = fdopen(sd, "r+");
  c = getc(f);
  ungetc(c, f);
  return c;
}
void SerialPi::flush() {
  while (available()) {
    unistd::read(sd, &c, 1);
  }
}
void SerialPi::setTimeout(long millis) { timeOut = millis; }
void SerialPi::end() { unistd::close(sd); }
timespec SerialPi::timeDiff(timespec start, timespec end) {
  timespec temp;
  if ((end.tv_nsec - start.tv_nsec) < 0) {
    temp.tv_sec = end.tv_sec - start.tv_sec - 1;
    temp.tv_nsec = 1000000000 + end.tv_nsec - start.tv_nsec;
  } else {
    temp.tv_sec = end.tv_sec - start.tv_sec;
    temp.tv_nsec = end.tv_nsec - start.tv_nsec;
  }
  return temp;
}
char *SerialPi::int2bin(int i) {
  size_t bits = sizeof(int) * CHAR_BIT;
  char *str = (char *)malloc(bits + 1);
  int firstCeros = 0;
  int size = bits;
  if (!str)
    return NULL;
  str[bits] = 0;
  unsigned u = *(unsigned *)&i;
  for (; bits--; u >>= 1)
    str[bits] = u & 1 ? '1' : '0';
  for (int i = 0; i < bits; i++) {
    if (str[i] == '0') {
      firstCeros++;
    } else {
      break;
    }
  }
  char *str_noceros = (char *)malloc(size - firstCeros + 1);
  for (int i = 0; i < (size - firstCeros); i++) {
    str_noceros[i] = str[firstCeros + i];
  }
  return str_noceros;
}
char *SerialPi::int2hex(int i) {
  char buffer[32];
  sprintf(buffer, "%x", i);
  char *hex = (char *)malloc(strlen(buffer) + 1);
  strcpy(hex, buffer);
  return hex;
}
char *SerialPi::int2oct(int i) {
  char buffer[32];
  sprintf(buffer, "%o", i);
  char *oct = (char *)malloc(strlen(buffer) + 1);
  strcpy(oct, buffer);
  return oct;
}
WirePi::WirePi() {
  REV = getBoardRev();
  if (map_peripheral(&gpio) == -1) {
    printf("Failed to map the physical GPIO registers into the virtual memory space.\n");
  }
  memfd = -1;
  i2c_byte_wait_us = 0;
  if ((memfd = open("/dev/mem", O_RDWR | O_SYNC)) < 0) {
    fprintf(stderr, "bcm2835_init: Unable to open /dev/mem: %s\n", strerror(errno));
    exit(1);
  }
  bcm2835_bsc01 = mapmem("bsc1", BLOCK_SIZE, memfd, BCM2835_BSC1_BASE2);
  if (bcm2835_bsc01 == MAP_FAILED)
    exit(1);
  gettimeofday(&start_program, NULL);
}
void WirePi::begin() {
  volatile uint32_t *paddr = bcm2835_bsc01 + BCM2835_BSC_DIV / 4;
  ch_gpio_fsel(RPI_V2_GPIO_P1_03, BCM2835_GPIO_FSEL_ALT0);
  ch_gpio_fsel(RPI_V2_GPIO_P1_05, BCM2835_GPIO_FSEL_ALT0);
  uint16_t cdiv = ch_peri_read(paddr);
  i2c_byte_wait_us = ((float)cdiv / BCM2835_CORE_CLK_HZ) * 1000000 * 9;
}
void WirePi::beginTransmission(unsigned char address) {
  volatile uint32_t *paddr = bcm2835_bsc01 + BCM2835_BSC_A / 4;
  ch_peri_write(paddr, address);
}
void WirePi::write(char data) {
  char i2cdata[1];
  i2cdata[0] = data;
  write(i2cdata, 1);
}
uint8_t WirePi::write(const char *buf, uint32_t len) {
  volatile uint32_t *dlen = bcm2835_bsc01 + BCM2835_BSC_DLEN / 4;
  volatile uint32_t *fifo = bcm2835_bsc01 + BCM2835_BSC_FIFO / 4;
  volatile uint32_t *status = bcm2835_bsc01 + BCM2835_BSC_S / 4;
  volatile uint32_t *control = bcm2835_bsc01 + BCM2835_BSC_C / 4;
  uint32_t remaining = len;
  uint32_t i = 0;
  uint8_t reason = BCM2835_I2C_REASON_OK;
  ch_peri_set_bits(control, BCM2835_BSC_C_CLEAR_1, BCM2835_BSC_C_CLEAR_1);
  ch_peri_write_nb(status, BCM2835_BSC_S_CLKT | BCM2835_BSC_S_ERR | BCM2835_BSC_S_DONE);
  ch_peri_write_nb(dlen, len);
  while (remaining && (i < BCM2835_BSC_FIFO_SIZE)) {
    ch_peri_write_nb(fifo, buf[i]);
    i++;
    remaining--;
  }
  ch_peri_write_nb(control, BCM2835_BSC_C_I2CEN | BCM2835_BSC_C_ST);
  while (!(ch_peri_read_nb(status) & BCM2835_BSC_S_DONE)) {
    while (remaining && (ch_peri_read_nb(status) & BCM2835_BSC_S_TXD)) {
      ch_peri_write_nb(fifo, buf[i]);
      i++;
      remaining--;
    }
  }
  if (ch_peri_read(status) & BCM2835_BSC_S_ERR) {
    reason = BCM2835_I2C_REASON_ERROR_NACK;
  } else if (ch_peri_read(status) & BCM2835_BSC_S_CLKT) {
    reason = BCM2835_I2C_REASON_ERROR_CLKT;
  } else if (remaining) {
    reason = BCM2835_I2C_REASON_ERROR_DATA;
  }
  ch_peri_set_bits(control, BCM2835_BSC_S_DONE, BCM2835_BSC_S_DONE);
  return reason;
}
void WirePi::endTransmission() {
  ch_gpio_fsel(RPI_V2_GPIO_P1_03, BCM2835_GPIO_FSEL_INPT);
  ch_gpio_fsel(RPI_V2_GPIO_P1_05, BCM2835_GPIO_FSEL_INPT);
}
void WirePi::requestFrom(unsigned char address, int quantity) {
  volatile uint32_t *paddr = bcm2835_bsc01 + BCM2835_BSC_A / 4;
  ch_peri_write(paddr, address);
  i2c_bytes_to_read = quantity;
}
unsigned char WirePi::read() {
  char buf;
  i2c_bytes_to_read = 1;
  read(&buf);
  return (unsigned char)buf;
}
uint8_t WirePi::read(char *buf) {
  volatile uint32_t *dlen = bcm2835_bsc01 + BCM2835_BSC_DLEN / 4;
  volatile uint32_t *fifo = bcm2835_bsc01 + BCM2835_BSC_FIFO / 4;
  volatile uint32_t *status = bcm2835_bsc01 + BCM2835_BSC_S / 4;
  volatile uint32_t *control = bcm2835_bsc01 + BCM2835_BSC_C / 4;
  uint32_t remaining = i2c_bytes_to_read;
  uint32_t i = 0;
  uint8_t reason = BCM2835_I2C_REASON_OK;
  ch_peri_set_bits(control, BCM2835_BSC_C_CLEAR_1, BCM2835_BSC_C_CLEAR_1);
  ch_peri_write_nb(status, BCM2835_BSC_S_CLKT | BCM2835_BSC_S_ERR | BCM2835_BSC_S_DONE);
  ch_peri_write_nb(dlen, i2c_bytes_to_read);
  ch_peri_write_nb(control, BCM2835_BSC_C_I2CEN | BCM2835_BSC_C_ST | BCM2835_BSC_C_READ);
  while (!(ch_peri_read_nb(status) & BCM2835_BSC_S_DONE)) {
    while (ch_peri_read_nb(status) & BCM2835_BSC_S_RXD) {
      buf[i] = ch_peri_read_nb(fifo);
      i++;
      remaining--;
    }
  }
  while (remaining && (ch_peri_read_nb(status) & BCM2835_BSC_S_RXD)) {
    buf[i] = ch_peri_read_nb(fifo);
    i++;
    remaining--;
  }
  if (ch_peri_read(status) & BCM2835_BSC_S_ERR) {
    reason = BCM2835_I2C_REASON_ERROR_NACK;
  } else if (ch_peri_read(status) & BCM2835_BSC_S_CLKT) {
    reason = BCM2835_I2C_REASON_ERROR_CLKT;
  } else if (remaining) {
    reason = BCM2835_I2C_REASON_ERROR_DATA;
  }
  ch_peri_set_bits(control, BCM2835_BSC_S_DONE, BCM2835_BSC_S_DONE);
  return reason;
}
uint8_t WirePi::read_rs(char *regaddr, char *buf, uint32_t len) {
  volatile uint32_t *dlen = bcm2835_bsc01 + BCM2835_BSC_DLEN / 4;
  volatile uint32_t *fifo = bcm2835_bsc01 + BCM2835_BSC_FIFO / 4;
  volatile uint32_t *status = bcm2835_bsc01 + BCM2835_BSC_S / 4;
  volatile uint32_t *control = bcm2835_bsc01 + BCM2835_BSC_C / 4;
  uint32_t remaining = len;
  uint32_t i = 0;
  uint8_t reason = BCM2835_I2C_REASON_OK;
  ch_peri_set_bits(control, BCM2835_BSC_C_CLEAR_1, BCM2835_BSC_C_CLEAR_1);
  ch_peri_write_nb(status, BCM2835_BSC_S_CLKT | BCM2835_BSC_S_ERR | BCM2835_BSC_S_DONE);
  ch_peri_write_nb(dlen, 1);
  ch_peri_write_nb(control, BCM2835_BSC_C_I2CEN);
  ch_peri_write_nb(fifo, regaddr[0]);
  ch_peri_write_nb(control, BCM2835_BSC_C_I2CEN | BCM2835_BSC_C_ST);
  while (!(ch_peri_read_nb(status) & BCM2835_BSC_S_TA)) {
    if (ch_peri_read(status) & BCM2835_BSC_S_DONE)
      break;
  }
  ch_peri_write_nb(dlen, len);
  ch_peri_write_nb(control, BCM2835_BSC_C_I2CEN | BCM2835_BSC_C_ST | BCM2835_BSC_C_READ);
  delayMicroseconds(i2c_byte_wait_us * 3);
  while (!(ch_peri_read_nb(status) & BCM2835_BSC_S_DONE)) {
    while (remaining && ch_peri_read_nb(status) & BCM2835_BSC_S_RXD) {
      buf[i] = ch_peri_read_nb(fifo);
      i++;
      remaining--;
    }
  }
  while (remaining && (ch_peri_read_nb(status) & BCM2835_BSC_S_RXD)) {
    buf[i] = ch_peri_read_nb(fifo);
    i++;
    remaining--;
  }
  if (ch_peri_read(status) & BCM2835_BSC_S_ERR) {
    reason = BCM2835_I2C_REASON_ERROR_NACK;
  } else if (ch_peri_read(status) & BCM2835_BSC_S_CLKT) {
    reason = BCM2835_I2C_REASON_ERROR_CLKT;
  } else if (remaining) {
    reason = BCM2835_I2C_REASON_ERROR_DATA;
  }
  ch_peri_set_bits(control, BCM2835_BSC_S_DONE, BCM2835_BSC_S_DONE);
  return reason;
}
int WirePi::map_peripheral(struct bcm2835_peripheral *p) {
  if ((p->mem_fd = open("/dev/mem", O_RDWR | O_SYNC)) < 0) {
    printf("Failed to open /dev/mem, try checking permissions.\n");
    return -1;
  }
  p->map = mmap(NULL, BLOCK_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, p->mem_fd, p->addr_p);
  if (p->map == MAP_FAILED) {
    perror("mmap");
    return -1;
  }
  p->addr = (volatile unsigned int *)p->map;
  return 0;
}
void WirePi::unmap_peripheral(struct bcm2835_peripheral *p) {
  munmap(p->map, BLOCK_SIZE);
  unistd::close(p->mem_fd);
}
void WirePi::wait_i2c_done() {
  int timeout = 50;
  while ((!((BSC0_S)&BSC_S_DONE)) && --timeout) {
    unistd::usleep(1000);
  }
  if (timeout == 0)
    printf("wait_i2c_done() timeout. Something went wrong.\n");
}
SPIPi::SPIPi() {
  REV = getBoardRev();
  uint8_t *mapaddr;
  if ((spi0Mem = (uint8_t *)malloc(BLOCK_SIZE + (PAGESIZE - 1))) == NULL) {
    fprintf(stderr, "bcm2835_init: spi0Mem malloc failed: %s\n", strerror(errno));
    exit(1);
  }
  mapaddr = spi0Mem;
  if (((uint32_t)mapaddr % PAGESIZE) != 0)
    mapaddr += PAGESIZE - ((uint32_t)mapaddr % PAGESIZE);
  spi0 = (uint32_t *)mmap(mapaddr, BLOCK_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, gpio.mem_fd, BCM2835_SPI0_BASE2);
  if ((int32_t)spi0 < 0) {
    fprintf(stderr, "bcm2835_init: mmap failed (spi0): %s\n", strerror(errno));
    exit(1);
  }
}
void SPIPi::begin() {
  ch_gpio_fsel(7, BCM2835_GPIO_FSEL_ALT0);
  ch_gpio_fsel(8, BCM2835_GPIO_FSEL_ALT0);
  ch_gpio_fsel(9, BCM2835_GPIO_FSEL_ALT0);
  ch_gpio_fsel(10, BCM2835_GPIO_FSEL_ALT0);
  ch_gpio_fsel(11, BCM2835_GPIO_FSEL_ALT0);
  volatile uint32_t *paddr = (volatile uint32_t *)spi0 + BCM2835_SPI0_CS / 4;
  ch_peri_write(paddr, 0);
  ch_peri_write_nb(paddr, BCM2835_SPI0_CS_CLEAR);
}
void SPIPi::end() {
  ch_gpio_fsel(7, BCM2835_GPIO_FSEL_INPT);
  ch_gpio_fsel(8, BCM2835_GPIO_FSEL_INPT);
  ch_gpio_fsel(9, BCM2835_GPIO_FSEL_INPT);
  ch_gpio_fsel(10, BCM2835_GPIO_FSEL_INPT);
  ch_gpio_fsel(11, BCM2835_GPIO_FSEL_INPT);
}
void SPIPi::setBitOrder(uint8_t order) {}
void SPIPi::setClockDivider(uint16_t divider) {
  volatile uint32_t *paddr = (volatile uint32_t *)spi0 + BCM2835_SPI0_CLK / 4;
  ch_peri_write(paddr, divider);
}
void SPIPi::setDataMode(uint8_t mode) {
  volatile uint32_t *paddr = (volatile uint32_t *)spi0 + BCM2835_SPI0_CS / 4;
  ch_peri_set_bits(paddr, mode << 2, BCM2835_SPI0_CS_CPOL | BCM2835_SPI0_CS_CPHA);
}
uint8_t SPIPi::transfer(uint8_t value) {
  volatile uint32_t *paddr = (volatile uint32_t *)spi0 + BCM2835_SPI0_CS / 4;
  volatile uint32_t *fifo = (volatile uint32_t *)spi0 + BCM2835_SPI0_FIFO / 4;
  ch_peri_set_bits(paddr, BCM2835_SPI0_CS_CLEAR, BCM2835_SPI0_CS_CLEAR);
  ch_peri_set_bits(paddr, BCM2835_SPI0_CS_TA, BCM2835_SPI0_CS_TA);
  while (!(ch_peri_read(paddr) & BCM2835_SPI0_CS_TXD))
    delayMicroseconds(10);
  ch_peri_write_nb(fifo, value);
  while (!(ch_peri_read_nb(paddr) & BCM2835_SPI0_CS_DONE))
    delayMicroseconds(10);
  uint32_t ret = ch_peri_read_nb(fifo);
  ch_peri_set_bits(paddr, 0, BCM2835_SPI0_CS_TA);
  return ret;
}
void SPIPi::transfernb(char *tbuf, char *rbuf, uint32_t len) {
  volatile uint32_t *paddr = (volatile uint32_t *)spi0 + BCM2835_SPI0_CS / 4;
  volatile uint32_t *fifo = (volatile uint32_t *)spi0 + BCM2835_SPI0_FIFO / 4;
  ch_peri_set_bits(paddr, BCM2835_SPI0_CS_CLEAR, BCM2835_SPI0_CS_CLEAR);
  ch_peri_set_bits(paddr, BCM2835_SPI0_CS_TA, BCM2835_SPI0_CS_TA);
  uint32_t i;
  for (i = 0; i < len; i++) {
    while (!(ch_peri_read(paddr) & BCM2835_SPI0_CS_TXD))
      delayMicroseconds(10);
    ch_peri_write_nb(fifo, tbuf[i]);
    while (!(ch_peri_read(paddr) & BCM2835_SPI0_CS_RXD))
      delayMicroseconds(10);
    rbuf[i] = ch_peri_read_nb(fifo);
  }
  while (!(ch_peri_read_nb(paddr) & BCM2835_SPI0_CS_DONE))
    delayMicroseconds(10);
  ch_peri_set_bits(paddr, 0, BCM2835_SPI0_CS_TA);
}
void SPIPi::chipSelect(uint8_t cs) {
  volatile uint32_t *paddr = (volatile uint32_t *)spi0 + BCM2835_SPI0_CS / 4;
  ch_peri_set_bits(paddr, cs, BCM2835_SPI0_CS_CS);
}
void SPIPi::setChipSelectPolarity(uint8_t cs, uint8_t active) {
  volatile uint32_t *paddr = (volatile uint32_t *)spi0 + BCM2835_SPI0_CS / 4;
  uint8_t shift = 21 + cs;
  ch_peri_set_bits(paddr, active << shift, 1 << shift);
}
uint32_t ch_peri_read(volatile uint32_t *paddr) {
  uint32_t ret = *paddr;
  ret = *paddr;
  return ret;
}
uint32_t ch_peri_read_nb(volatile uint32_t *paddr) { return *paddr; }
void ch_peri_write(volatile uint32_t *paddr, uint32_t value) {
  *paddr = value;
  *paddr = value;
}
void ch_peri_write_nb(volatile uint32_t *paddr, uint32_t value) { *paddr = value; }
void ch_peri_set_bits(volatile uint32_t *paddr, uint32_t value, uint32_t mask) {
  uint32_t v = ch_peri_read(paddr);
  v = (v & ~mask) | (value & mask);
  ch_peri_write(paddr, v);
}
void delay(long millis) { unistd::usleep(millis * 1000); }
void delayMicroseconds(long micros) {
  if (micros > 100) {
    struct timespec tim, tim2;
    tim.tv_sec = 0;
    tim.tv_nsec = micros * 1000;
    if (nanosleep(&tim, &tim2) < 0) {
      fprintf(stderr, "Nano sleep system call failed \n");
      exit(1);
    }
  } else {
    struct timeval tNow, tLong, tEnd;
    gettimeofday(&tNow, NULL);
    tLong.tv_sec = micros / 1000000;
    tLong.tv_usec = micros % 1000000;
    timeradd(&tNow, &tLong, &tEnd);
    while (timercmp(&tNow, &tEnd, <))
      gettimeofday(&tNow, NULL);
  }
}
uint8_t shiftIn(uint8_t dPin, uint8_t cPin, bcm2835SPIBitOrder order) {
  uint8_t value = 0;
  int8_t i;
  if (order == BCM2835_SPI_BIT_ORDER_MSBFIRST)
    for (i = 7; i >= 0; --i) {
      digitalWrite(cPin, HIGH);
      value |= digitalRead(dPin) << i;
      digitalWrite(cPin, LOW);
    }
  else
    for (i = 0; i < 8; ++i) {
      digitalWrite(cPin, HIGH);
      value |= digitalRead(dPin) << i;
      digitalWrite(cPin, LOW);
    }
  return value;
}
void shiftOut(uint8_t dPin, uint8_t cPin, bcm2835SPIBitOrder order, uint8_t val) {
  int8_t i;
  if (order == BCM2835_SPI_BIT_ORDER_MSBFIRST)
    for (i = 7; i >= 0; --i) {
      digitalWrite(dPin, val & (1 << i));
      digitalWrite(cPin, HIGH);
      digitalWrite(cPin, LOW);
    }
  else
    for (i = 0; i < 8; ++i) {
      digitalWrite(dPin, val & (1 << i));
      digitalWrite(cPin, HIGH);
      digitalWrite(cPin, LOW);
    }
}
void pinMode(int pin, Pinmode mode) {
  pin = raspberryPinNumber(pin);
  if (mode == OUTPUT) {
    switch (pin) {
    case 4:
      GPFSEL0 &= ~(7 << 12);
      GPFSEL0 |= (1 << 12);
      break;
    case 8:
      GPFSEL0 &= ~(7 << 24);
      GPFSEL0 |= (1 << 24);
      break;
    case 9:
      GPFSEL0 &= ~(7 << 27);
      GPFSEL0 |= (1 << 27);
      break;
    case 10:
      GPFSEL1 &= ~(7 << 0);
      GPFSEL1 |= (1 << 0);
      break;
    case 11:
      GPFSEL1 &= ~(7 << 3);
      GPFSEL1 |= (1 << 3);
      break;
    case 17:
      GPFSEL1 &= ~(7 << 21);
      GPFSEL1 |= (1 << 21);
      break;
    case 18:
      GPFSEL1 &= ~(7 << 24);
      GPFSEL1 |= (1 << 24);
      break;
    case 21:
      GPFSEL2 &= ~(7 << 3);
      GPFSEL2 |= (1 << 3);
      break;
    case 27:
      GPFSEL2 &= ~(7 << 21);
      GPFSEL2 |= (1 << 21);
      break;
    case 22:
      GPFSEL2 &= ~(7 << 6);
      GPFSEL2 |= (1 << 6);
      break;
    case 23:
      GPFSEL2 &= ~(7 << 9);
      GPFSEL2 |= (1 << 9);
      break;
    case 24:
      GPFSEL2 &= ~(7 << 12);
      GPFSEL2 |= (1 << 12);
      break;
    case 25:
      GPFSEL2 &= ~(7 << 15);
      GPFSEL2 |= (1 << 15);
      break;
    }
  } else if (mode == INPUT) {
    switch (pin) {
    case 4:
      GPFSEL0 &= ~(7 << 12);
      break;
    case 8:
      GPFSEL0 &= ~(7 << 24);
      break;
    case 9:
      GPFSEL0 &= ~(7 << 27);
      break;
    case 10:
      GPFSEL1 &= ~(7 << 0);
      break;
    case 11:
      GPFSEL1 &= ~(7 << 3);
      break;
    case 17:
      GPFSEL1 &= ~(7 << 21);
      break;
    case 18:
      GPFSEL1 &= ~(7 << 24);
      break;
    case 21:
      GPFSEL2 &= ~(7 << 3);
      break;
    case 27:
      GPFSEL2 &= ~(7 << 3);
      break;
    case 22:
      GPFSEL2 &= ~(7 << 6);
      break;
    case 23:
      GPFSEL2 &= ~(7 << 9);
      break;
    case 24:
      GPFSEL2 &= ~(7 << 12);
      break;
    case 25:
      GPFSEL2 &= ~(7 << 15);
      break;
    }
  }
}
void digitalWrite(int pin, int value) {
  pin = raspberryPinNumber(pin);
  if (value == HIGH) {
    switch (pin) {
    case 4:
      GPSET0 = BIT_4;
      break;
    case 8:
      GPSET0 = BIT_8;
      break;
    case 9:
      GPSET0 = BIT_9;
      break;
    case 10:
      GPSET0 = BIT_10;
      break;
    case 11:
      GPSET0 = BIT_11;
      break;
    case 17:
      GPSET0 = BIT_17;
      break;
    case 18:
      GPSET0 = BIT_18;
      break;
    case 21:
      GPSET0 = BIT_21;
      break;
    case 27:
      GPSET0 = BIT_27;
      break;
    case 22:
      GPSET0 = BIT_22;
      break;
    case 23:
      GPSET0 = BIT_23;
      break;
    case 24:
      GPSET0 = BIT_24;
      break;
    case 25:
      GPSET0 = BIT_25;
      break;
    }
  } else if (value == LOW) {
    switch (pin) {
    case 4:
      GPCLR0 = BIT_4;
      break;
    case 8:
      GPCLR0 = BIT_8;
      break;
    case 9:
      GPCLR0 = BIT_9;
      break;
    case 10:
      GPCLR0 = BIT_10;
      break;
    case 11:
      GPCLR0 = BIT_11;
      break;
    case 17:
      GPCLR0 = BIT_17;
      break;
    case 18:
      GPCLR0 = BIT_18;
      break;
    case 21:
      GPCLR0 = BIT_21;
      break;
    case 27:
      GPCLR0 = BIT_27;
      break;
    case 22:
      GPCLR0 = BIT_22;
      break;
    case 23:
      GPCLR0 = BIT_23;
      break;
    case 24:
      GPCLR0 = BIT_24;
      break;
    case 25:
      GPCLR0 = BIT_25;
      break;
    }
  }
  delayMicroseconds(1);
}
int digitalRead(int pin) {
  Digivalue value;
  pin = raspberryPinNumber(pin);
  switch (pin) {
  case 4:
    if (GPLEV0 & BIT_4) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  case 8:
    if (GPLEV0 & BIT_8) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  case 9:
    if (GPLEV0 & BIT_9) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  case 10:
    if (GPLEV0 & BIT_10) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  case 11:
    if (GPLEV0 & BIT_11) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  case 17:
    if (GPLEV0 & BIT_17) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  case 18:
    if (GPLEV0 & BIT_18) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  case 21:
    if (GPLEV0 & BIT_21) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  case 27:
    if (GPLEV0 & BIT_27) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  case 22:
    if (GPLEV0 & BIT_22) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  case 23:
    if (GPLEV0 & BIT_23) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  case 24:
    if (GPLEV0 & BIT_24) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  case 25:
    if (GPLEV0 & BIT_25) {
      value = HIGH;
    } else {
      value = LOW;
    };
    break;
  }
  return value;
}
int analogRead(int pin) {
  int value;
  char selected_channel[1];
  char read_values[2];
  if (pin == 0) {
    selected_channel[0] = 0xDC;
  } else if (pin == 1) {
    selected_channel[0] = 0x9C;
  } else if (pin == 2) {
    selected_channel[0] = 0xCC;
  } else if (pin == 3) {
    selected_channel[0] = 0x8C;
  } else if (pin == 4) {
    selected_channel[0] = 0xAC;
  } else if (pin == 5) {
    selected_channel[0] = 0xEC;
  } else if (pin == 6) {
    selected_channel[0] = 0xBC;
  } else if (pin == 7) {
    selected_channel[0] = 0xFC;
  }
  Wire.begin();
  Wire.beginTransmission(8);
  Wire.read_rs(selected_channel, read_values, 2);
  Wire.read_rs(selected_channel, read_values, 2);
  value = int(read_values[0]) * 16 + int(read_values[1] >> 4);
  value = value * 1023 / 4095;
  return value;
}
void attachInterrupt(int p, void (*f)(), Digivalue m) {
  int GPIOPin = raspberryPinNumber(p);
  pthread_t *threadId = getThreadIdFromPin(p);
  struct ThreadArg *threadArgs = (ThreadArg *)malloc(sizeof(ThreadArg));
  threadArgs->func = f;
  threadArgs->pin = GPIOPin;
  FILE *fp = fopen("/sys/class/gpio/export", "w");
  if (fp == NULL) {
    fprintf(stderr, "Unable to export pin %d for interrupt\n", p);
    exit(1);
  } else {
    fprintf(fp, "%d", GPIOPin);
  }
  fclose(fp);
  delay(1L);
  char *interruptFile = NULL;
  asprintf(&interruptFile, "/sys/class/gpio/gpio%d/edge", GPIOPin);
  fp = fopen(interruptFile, "w");
  if (fp == NULL) {
    fprintf(stderr, "Unable to set detection type on pin %d\n", p);
    exit(1);
  } else {
    switch (m) {
    case RISING:
      fprintf(fp, "rising");
      break;
    case FALLING:
      fprintf(fp, "falling");
      break;
    default:
      fprintf(fp, "both");
      break;
    }
  }
  fclose(fp);
  if (*threadId == 0) {
    pthread_create(threadId, NULL, threadFunction, (void *)threadArgs);
  } else {
    pthread_cancel(*threadId);
    pthread_create(threadId, NULL, threadFunction, (void *)threadArgs);
  }
}
void detachInterrupt(int p) {
  int GPIOPin = raspberryPinNumber(p);
  FILE *fp = fopen("/sys/class/gpio/unexport", "w");
  if (fp == NULL) {
    fprintf(stderr, "Unable to unexport pin %d for interrupt\n", p);
    exit(1);
  } else {
    fprintf(fp, "%d", GPIOPin);
  }
  fclose(fp);
  pthread_t *threadId = getThreadIdFromPin(p);
  pthread_cancel(*threadId);
}
long millis() {
  long elapsedTime;
  gettimeofday(&end_point, NULL);
  elapsedTime = (end_point.tv_sec - start_program.tv_sec) * 1000.0;
  elapsedTime += (end_point.tv_usec - start_program.tv_usec) / 1000.0;
  return elapsedTime;
}
int getBoardRev() {
  FILE *cpu_info;
  char line[120];
  char *c, finalChar;
  static int rev = 0;
  if (REV != 0)
    return REV;
  if ((cpu_info = fopen("/proc/cpuinfo", "r")) == NULL) {
    fprintf(stderr, "Unable to open /proc/cpuinfo. Cannot determine board reivision.\n");
    exit(1);
  }
  while (fgets(line, 120, cpu_info) != NULL) {
    if (strncmp(line, "Revision", 8) == 0)
      break;
  }
  fclose(cpu_info);
  if (line == NULL) {
    fprintf(stderr, "Unable to determine board revision from /proc/cpuinfo.\n");
    exit(1);
  }
  for (c = line; *c; ++c)
    if (isdigit(*c))
      break;
  if (!isdigit(*c)) {
    fprintf(stderr, "Unable to determine board revision from /proc/cpuinfo\n");
    fprintf(stderr, "	(Info not found in: %s\n", line);
    exit(1);
  }
  finalChar = c[strlen(c) - 2];
  if ((finalChar == '2') || (finalChar == '3')) {
    bsc0 = bsc_rev1;
    return 1;
  } else {
    bsc0 = bsc_rev2;
    return 2;
  }
}
uint32_t *mapmem(const char *msg, size_t size, int fd, off_t off) {
  uint32_t *map = (uint32_t *)mmap(NULL, size, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, off);
  if (MAP_FAILED == map)
    fprintf(stderr, "bcm2835_init: %s mmap failed: %s\n", msg, strerror(errno));
  return map;
}
int raspberryPinNumber(int arduinoPin) {
  switch (arduinoPin) {
  case 2:
    return 18;
    break;
  case 3:
    return 23;
    break;
  case 4:
    return 24;
    break;
  case 5:
    return 25;
    break;
  case 6:
    return 4;
    break;
  case 7:
    return 17;
    break;
  case 8:
    if (REV == 1) {
      return 21;
    } else {
      return 27;
    }
    break;
  case 9:
    return 22;
    break;
  case 10:
    return 8;
    break;
  case 11:
    return 10;
    break;
  case 12:
    return 9;
    break;
  case 13:
    return 11;
    break;
  }
}
void ch_gpio_fsel(uint8_t pin, uint8_t mode) {
  volatile uint32_t *paddr = (volatile uint32_t *)gpio.map + BCM2835_GPFSEL0 / 4 + (pin / 10);
  uint8_t shift = (pin % 10) * 3;
  uint32_t mask = BCM2835_GPIO_FSEL_MASK << shift;
  uint32_t value = mode << shift;
  ch_peri_set_bits(paddr, value, mask);
}
pthread_t *getThreadIdFromPin(int pin) {
  switch (pin) {
  case 2:
    return &idThread2;
    break;
  case 3:
    return &idThread3;
    break;
  case 4:
    return &idThread4;
    break;
  case 5:
    return &idThread5;
    break;
  case 6:
    return &idThread6;
    break;
  case 7:
    return &idThread7;
    break;
  case 8:
    return &idThread8;
    break;
  case 9:
    return &idThread9;
    break;
  case 10:
    return &idThread10;
    break;
  case 11:
    return &idThread11;
    break;
  case 12:
    return &idThread12;
    break;
  case 13:
    return &idThread13;
    break;
  }
}
void *threadFunction(void *args) {
  ThreadArg *arguments = (ThreadArg *)args;
  int pin = arguments->pin;
  int GPIO_FN_MAXLEN = 32;
  int RDBUF_LEN = 5;
  char fn[GPIO_FN_MAXLEN];
  int fd, ret;
  struct pollfd pfd;
  char rdbuf[RDBUF_LEN];
  memset(rdbuf, 0x00, RDBUF_LEN);
  memset(fn, 0x00, GPIO_FN_MAXLEN);
  snprintf(fn, GPIO_FN_MAXLEN - 1, "/sys/class/gpio/gpio%d/value", pin);
  fd = open(fn, O_RDONLY);
  if (fd < 0) {
    perror(fn);
    exit(1);
  }
  pfd.fd = fd;
  pfd.events = POLLPRI;
  ret = unistd::read(fd, rdbuf, RDBUF_LEN - 1);
  if (ret < 0) {
    perror("Error reading interrupt file\n");
    exit(1);
  }
  while (1) {
    memset(rdbuf, 0x00, RDBUF_LEN);
    unistd::lseek(fd, 0, SEEK_SET);
    ret = poll(&pfd, 1, -1);
    if (ret < 0) {
      perror("Error waiting for interrupt\n");
      unistd::close(fd);
      exit(1);
    }
    if (ret == 0) {
      printf("Timeout\n");
      continue;
    }
    ret = unistd::read(fd, rdbuf, RDBUF_LEN - 1);
    if (ret < 0) {
      perror("Error reading interrupt file\n");
      exit(1);
    }
    arguments->func();
  }
}
SerialPi Serial = SerialPi();
WirePi Wire = WirePi();
SPIPi SPI = SPIPi();
