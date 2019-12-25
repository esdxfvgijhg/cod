#include "contiki.h"
#include "lwm2m-engine.h"
#include "dev/serial-line.h"
#define DEBUG DEBUG_PRINT

extern char* obj_serial_data;

PROCESS(lwm2m_example_client, "IoT-LAB LWM2M client example");
AUTOSTART_PROCESSES(&lwm2m_example_client);

static void
setup_lwm2m_servers(void)
{
#ifdef LWM2M_SERVER_ADDRESS
  uip_ipaddr_t addr;
  if(uiplib_ipaddrconv(LWM2M_SERVER_ADDRESS, &addr)) {
    lwm2m_engine_register_with_bootstrap_server(&addr, 0);
    lwm2m_engine_register_with_server(&addr, 0);
  }
#endif /* LWM2M_SERVER_ADDRESS */

  lwm2m_engine_use_bootstrap_server(REGISTER_WITH_LWM2M_BOOTSTRAP_SERVER);
  lwm2m_engine_use_registration_server(REGISTER_WITH_LWM2M_SERVER);
}
/*---------------------------------------------------------------------------*/
PROCESS_THREAD(lwm2m_example_client, ev, data)
{
  static struct etimer timer;

  PROCESS_BEGIN();

  PROCESS_PAUSE();

  /* Initialize the OMA LWM2M engine */
  lwm2m_engine_init();

  /* Register default LWM2M objects */
  lwm2m_engine_register_default_objects();

  /* Register temperature object */
  object_temperature_init();

  /* Register leds object */
  object_leds_init();

  /* Register accelerometer object */
  object_accelerometer_init();

  /* Register magnetometer object */
  object_magnetometer_init();

  /* Register pressure object */
  //object_pressure_init();

  /* Register gyrometer object */
  object_gyrometer_init();

  /* Register serial object */
  object_serial_init();


  setup_lwm2m_servers();

  etimer_set(&timer, CLOCK_SECOND *30);

  while(1) {
    PROCESS_WAIT_EVENT();
    if (ev == PROCESS_EVENT_TIMER) {
      /* Call the temperature object handler */
      object_temperature_handle();
      etimer_restart(&timer);
    }
    if(ev == serial_line_event_message) {
      obj_serial_data = (char*)data;
      /* Call the serial object handler */
      object_serial_handle();
    }
  }

  PROCESS_END();
}
