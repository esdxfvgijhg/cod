#include "contiki.h"

#include "lib/random.h"
#include <stdlib.h>
#include "lwm2m-object.h"
#include "lwm2m-engine.h"

//https://github.com/IPSO-Alliance/pub/blob/master/reg/xml/3341.xml


/*---------------------------------------------------------------------------*/

char* obj_serial_data = "No serial input ...";

static int
read_serial(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  return ctx->writer->write_string(ctx, outbuf, outsize,
                                   obj_serial_data, strlen(obj_serial_data));
}

static int
write_serial(lwm2m_context_t *ctx, const uint8_t *inbuf, size_t insize,
            uint8_t *outbuf, size_t outsize)
{
  size_t len;
  char text_serial[100];
  len = ctx->reader->read_string(ctx, inbuf, insize,
                                 (uint8_t *)&text_serial, sizeof(text_serial)); 
  obj_serial_data = text_serial;
  printf("%s\n", obj_serial_data);
  return len;
}


/*---------------------------------------------------------------------------*/
LWM2M_RESOURCES(serial_resources,
                /* serial text */
                LWM2M_RESOURCE_CALLBACK(5527, { read_serial, write_serial, NULL }),
                );
LWM2M_INSTANCES(serial_instances,
                LWM2M_INSTANCE(0, serial_resources));
LWM2M_OBJECT(serial, 3341, serial_instances);
/*---------------------------------------------------------------------------*/

void
object_serial_handle(void)
{
  printf("Notify observer serial sensor\n");
  lwm2m_object_notify_observers(&serial, "/0/5527");
}

void
object_serial_init(void)
{
  /* register this device */
  lwm2m_engine_register_object(&serial);
}

