
#ifndef arduPi_h
#define arduPi_h
#include "bcm2835.h"
#include <algorithm>
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <netinet/in.h>
#include <poll.h>
#include <pthread.h>
#include <signal.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/ipc.h>
#include <sys/mman.h>
#include <sys/sem.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <termios.h>
#include <time.h>
#define IOBASE 0x3f000000
#define GPIO_BASE2 (IOBASE + 0x200000)
#define BCM2835_SPI0_BASE2 (IOBASE + 0x204000)
#define BCM2835_BSC1_BASE2 (IOBASE + 0x804000)
#define BCM2835_BSC_C 0x0000
#define BCM2835_BSC_S 0x0004
#define BCM2835_BSC_DLEN 0x0008
#define BCM2835_BSC_A 0x000c
#define BCM2835_BSC_FIFO 0x0010
#define BCM2835_BSC_DIV 0x0014
#define BCM2835_BSC_DEL 0x0018
#define BCM2835_BSC_CLKT 0x001c
#define BCM2835_BSC_C_I2CEN 0x00008000
#define BCM2835_BSC_C_INTR 0x00000400
#define BCM2835_BSC_C_INTT 0x00000200
#define BCM2835_BSC_C_INTD 0x00000100
#define BCM2835_BSC_C_ST 0x00000080
#define BCM2835_BSC_C_CLEAR_1 0x00000020
#define BCM2835_BSC_C_CLEAR_2 0x00000010
#define BCM2835_BSC_C_READ 0x00000001
#define BCM2835_BSC_S_CLKT 0x00000200
#define BCM2835_BSC_S_ERR 0x00000100
#define BCM2835_BSC_S_RXF 0x00000080
#define BCM2835_BSC_S_TXE 0x00000040
#define BCM2835_BSC_S_RXD 0x00000020
#define BCM2835_BSC_S_TXD 0x00000010
#define BCM2835_BSC_S_RXR 0x00000008
#define BCM2835_BSC_S_TXW 0x00000004
#define BCM2835_BSC_S_DONE 0x00000002
#define BCM2835_BSC_S_TA 0x00000001
#define BCM2835_BSC_FIFO_SIZE 16
#define BCM2835_CORE_CLK_HZ 250000000
#define BSC0_C *(bsc0.addr + 0x00)
#define BSC0_S *(bsc0.addr + 0x01)
#define BSC0_DLEN *(bsc0.addr + 0x02)
#define BSC0_A *(bsc0.addr + 0x03)
#define BSC0_FIFO *(bsc0.addr + 0x04)
#define BSC_C_I2CEN (1 << 15)
#define BSC_C_INTR (1 << 10)
#define BSC_C_INTT (1 << 9)
#define BSC_C_INTD (1 << 8)
#define BSC_C_ST (1 << 7)
#define BSC_C_CLEAR (1 << 4)
#define BSC_C_READ 1
#define START_READ BSC_C_I2CEN | BSC_C_ST | BSC_C_CLEAR | BSC_C_READ
#define START_WRITE BSC_C_I2CEN | BSC_C_ST
#define BSC_S_CLKT (1 << 9)
#define BSC_S_ERR (1 << 8)
#define BSC_S_RXF (1 << 7)
#define BSC_S_TXE (1 << 6)
#define BSC_S_RXD (1 << 5)
#define BSC_S_TXD (1 << 4)
#define BSC_S_RXR (1 << 3)
#define BSC_S_TXW (1 << 2)
#define BSC_S_DONE (1 << 1)
#define BSC_S_TA 1
#define CLEAR_STATUS BSC_S_CLKT | BSC_S_ERR | BSC_S_DONE
#define GPFSEL0 *(gpio.addr + 0)
#define GPFSEL1 *(gpio.addr + 1)
#define GPFSEL2 *(gpio.addr + 2)
#define GPFSEL3 *(gpio.addr + 3)
#define GPFSEL4 *(gpio.addr + 4)
#define GPFSEL5 *(gpio.addr + 5)
#define GPSET0 *(gpio.addr + 7)
#define GPSET1 *(gpio.addr + 8)
#define GPCLR0 *(gpio.addr + 10)
#define GPCLR1 *(gpio.addr + 11)
#define GPLEV0 *(gpio.addr + 13)
#define GPLEV1 *(gpio.addr + 14)
#define BIT_4 (1 << 4)
#define BIT_8 (1 << 8)
#define BIT_9 (1 << 9)
#define BIT_10 (1 << 10)
#define BIT_11 (1 << 11)
#define BIT_17 (1 << 17)
#define BIT_18 (1 << 18)
#define BIT_21 (1 << 21)
#define BIT_27 (1 << 27)
#define BIT_22 (1 << 22)
#define BIT_23 (1 << 23)
#define BIT_24 (1 << 24)
#define BIT_25 (1 << 25)
#define PAGESIZE 4096
#define BLOCK_SIZE 4096
#define BCM2835_SPI0_CS 0x0000
#define BCM2835_SPI0_FIFO 0x0004
#define BCM2835_SPI0_CLK 0x0008
#define BCM2835_SPI0_DLEN 0x000c
#define BCM2835_SPI0_LTOH 0x0010
#define BCM2835_SPI0_DC 0x0014
#define BCM2835_SPI0_CS_LEN_LONG 0x02000000
#define BCM2835_SPI0_CS_DMA_LEN 0x01000000
#define BCM2835_SPI0_CS_CSPOL2 0x00800000
#define BCM2835_SPI0_CS_CSPOL1 0x00400000
#define BCM2835_SPI0_CS_CSPOL0 0x00200000
#define BCM2835_SPI0_CS_RXF 0x00100000
#define BCM2835_SPI0_CS_RXR 0x00080000
#define BCM2835_SPI0_CS_TXD 0x00040000
#define BCM2835_SPI0_CS_RXD 0x00020000
#define BCM2835_SPI0_CS_DONE 0x00010000
#define BCM2835_SPI0_CS_TE_EN 0x00008000
#define BCM2835_SPI0_CS_LMONO 0x00004000
#define BCM2835_SPI0_CS_LEN 0x00002000
#define BCM2835_SPI0_CS_REN 0x00001000
#define BCM2835_SPI0_CS_ADCS 0x00000800
#define BCM2835_SPI0_CS_INTR 0x00000400
#define BCM2835_SPI0_CS_INTD 0x00000200
#define BCM2835_SPI0_CS_DMAEN 0x00000100
#define BCM2835_SPI0_CS_TA 0x00000080
#define BCM2835_SPI0_CS_CSPOL 0x00000040
#define BCM2835_SPI0_CS_CLEAR 0x00000030
#define BCM2835_SPI0_CS_CLEAR_RX 0x00000020
#define BCM2835_SPI0_CS_CLEAR_TX 0x00000010
#define BCM2835_SPI0_CS_CPOL 0x00000008
#define BCM2835_SPI0_CS_CPHA 0x00000004
#define BCM2835_SPI0_CS_CS 0x00000003
#define BCM2835_GPFSEL0 0x0000
#define BCM2835_GPEDS0 0x0040
#define BCM2835_GPREN0 0x004c
#define BCM2835_GPHEN0 0x0064
#define BCM2835_GPLEN0 0x0070
#define CS 10
#define MOSI 11
#define MISO 12
#define SCK 13
static int REV = 0;
#define LSBFIRST 0
#define MSBFIRST 1
#define SPI_MODE0 0
#define SPI_MODE1 1
#define SPI_MODE2 2
#define SPI_MODE3 3
#define SPI_CLOCK_DIV65536 0
#define SPI_CLOCK_DIV32768 32768
#define SPI_CLOCK_DIV16384 16384
#define SPI_CLOCK_DIV8192 8192
#define SPI_CLOCK_DIV4096 4096
#define SPI_CLOCK_DIV2048 2048
#define SPI_CLOCK_DIV1024 1024
#define SPI_CLOCK_DIV512 512
#define SPI_CLOCK_DIV256 256
#define SPI_CLOCK_DIV128 128
#define SPI_CLOCK_DIV64 64
#define SPI_CLOCK_DIV32 32
#define SPI_CLOCK_DIV16 16
#define SPI_CLOCK_DIV8 8
#define SPI_CLOCK_DIV4 4
#define SPI_CLOCK_DIV2 2
#define SPI_CLOCK_DIV1 1
namespace unistd {
#include <unistd.h>
};
enum Representation { BIN, OCT, DEC, HEX, BYTE };
typedef enum { INPUT, OUTPUT } Pinmode;
typedef enum { LOW = 0, HIGH = 1, RISING = 2, FALLING = 3, BOTH = 4 } Digivalue;
typedef bool boolean;
typedef unsigned char byte;
struct bcm2835_peripheral {
  unsigned long addr_p;
  int mem_fd;
  void *map;
  volatile unsigned int *addr;
};
struct ThreadArg {
  void (*func)();
  int pin;
};
class SerialPi {
private:
  int sd, status;
  const char *serialPort;
  unsigned char c;
  struct termios options;
  int speed;
  long timeOut;
  timespec time1, time2;
  timespec timeDiff(timespec start, timespec end);
  char *int2bin(int i);
  char *int2hex(int i);
  char *int2oct(int i);

public:
  SerialPi();
  void begin(int serialSpeed);
  int available();
  char read();
  int readBytes(char message[], int size);
  int readBytesUntil(char character, char buffer[], int length);
  bool find(const char *target);
  bool findUntil(const char *target, const char *terminal);
  long parseInt();
  float parseFloat();
  char peek();
  void print(const char *message);
  void print(char message);
  void print(unsigned char i, Representation rep);
  void print(float f, int precission);
  void println(const char *message);
  void println(char message);
  void println(int i, Representation rep);
  void println(float f, int precission);
  int write(unsigned char message);
  int write(const char *message);
  int write(char *message, int size);
  void flush();
  void setTimeout(long millis);
  void end();
};
class WirePi {
private:
  int memfd;
  int i2c_byte_wait_us;
  int i2c_bytes_to_read;
  void dump_bsc_status();
  int map_peripheral(struct bcm2835_peripheral *p);
  void unmap_peripheral(struct bcm2835_peripheral *p);
  void wait_i2c_done();

public:
  WirePi();
  void begin();
  void beginTransmission(unsigned char address);
  void write(char data);
  uint8_t write(const char *buf, uint32_t len);
  void endTransmission();
  void requestFrom(unsigned char address, int quantity);
  unsigned char read();
  uint8_t read(char *buf);
  uint8_t read_rs(char *regaddr, char *buf, uint32_t len);
};
class SPIPi {
public:
  SPIPi();
  void begin();
  void end();
  void setBitOrder(uint8_t order);
  void setClockDivider(uint16_t divider);
  void setDataMode(uint8_t mode);
  void chipSelect(uint8_t cs);
  void setChipSelectPolarity(uint8_t cs, uint8_t active);
  uint8_t transfer(uint8_t value);
  void transfernb(char *tbuf, char *rbuf, uint32_t len);
};
void pinMode(int pin, Pinmode mode);
void digitalWrite(int pin, int value);
void delay(long millis);
void delayMicroseconds(long micros);
int digitalRead(int pin);
int analogRead(int pin);
uint8_t shiftIn(uint8_t dPin, uint8_t cPin, bcm2835SPIBitOrder order);
void shiftOut(uint8_t dPin, uint8_t cPin, bcm2835SPIBitOrder order, uint8_t val);
void attachInterrupt(int p, void (*f)(), Digivalue m);
void detachInterrupt(int p);
void setup();
void loop();
long millis();
int getBoardRev();
uint32_t *mapmem(const char *msg, size_t size, int fd, off_t off);
void setBoardRev(int rev);
int raspberryPinNumber(int arduinoPin);
pthread_t *getThreadIdFromPin(int pin);
uint32_t ch_peri_read(volatile uint32_t *paddr);
uint32_t ch_peri_read_nb(volatile uint32_t *paddr);
void ch_peri_write(volatile uint32_t *paddr, uint32_t value);
void ch_peri_write_nb(volatile uint32_t *paddr, uint32_t value);
void ch_peri_set_bits(volatile uint32_t *paddr, uint32_t value, uint32_t mask);
void ch_gpio_fsel(uint8_t pin, uint8_t mode);
void *threadFunction(void *args);
extern SerialPi Serial;
extern WirePi Wire;
extern SPIPi SPI;
#endif
