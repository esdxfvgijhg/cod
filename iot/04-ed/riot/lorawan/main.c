#include "fmt.h"
#include "msg.h"
#include "net/loramac.h"
#include "periph/rtc.h"
#include "semtech_loramac.h"
#include "thread.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define PERIOD (20U)
#define SENDER_PRIO (THREAD_PRIORITY_MAIN - 1)
static kernel_pid_t sender_pid;
static char sender_stack[THREAD_STACKSIZE_MAIN / 2];
semtech_loramac_t loramac;
static const char *message = "This is RIOT!";
static uint8_t deveui[LORAMAC_DEVEUI_LEN];
static uint8_t appeui[LORAMAC_APPEUI_LEN];
static uint8_t appkey[LORAMAC_APPKEY_LEN];
static void rtc_cb(void *arg) {
  (void)arg;
  msg_t msg;
  msg_send(&msg, sender_pid);
}
static void _prepare_next_alarm(void) {
  struct tm time;
  rtc_get_time(&time);
  time.tm_sec += PERIOD;
  mktime(&time);
  rtc_set_alarm(&time, rtc_cb, NULL);
}
static void _send_message(void) {
  printf("Sending: %s\n", message);
  uint8_t ret = semtech_loramac_send(&loramac, (uint8_t *)message, strlen(message));
  if (ret != SEMTECH_LORAMAC_TX_OK) {
    printf("Cannot send message '%s', ret code: %d\n", message, ret);
    return;
  }
  semtech_loramac_recv(&loramac);
}
static void *sender(void *arg) {
  (void)arg;
  msg_t msg;
  msg_t msg_queue[8];
  msg_init_queue(msg_queue, 8);
  while (1) {
    msg_receive(&msg);
    _send_message();
    _prepare_next_alarm();
  }
  return NULL;
}
int main(void) {
  puts("LoRaWAN Class A low-power application");
  puts("=====================================");
  fmt_hex_bytes(deveui, DEVEUI);
  fmt_hex_bytes(appeui, APPEUI);
  fmt_hex_bytes(appkey, APPKEY);
  semtech_loramac_init(&loramac);
  semtech_loramac_set_deveui(&loramac, deveui);
  semtech_loramac_set_appeui(&loramac, appeui);
  semtech_loramac_set_appkey(&loramac, appkey);
  semtech_loramac_set_dr(&loramac, LORAMAC_DR_5);
  puts("Starting join procedure");
  if (semtech_loramac_join(&loramac, LORAMAC_JOIN_OTAA) != SEMTECH_LORAMAC_JOIN_SUCCEEDED) {
    puts("Join procedure failed");
    return 1;
  }
  puts("Join procedure succeeded");
  sender_pid = thread_create(sender_stack, sizeof(sender_stack), SENDER_PRIO, 0, sender, NULL, "sender");
  msg_t msg;
  msg_send(&msg, sender_pid);
  return 0;
}
