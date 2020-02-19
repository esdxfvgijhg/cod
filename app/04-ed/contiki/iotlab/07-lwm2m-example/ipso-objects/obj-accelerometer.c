#include "contiki.h"

#include "lib/random.h"
#include <stdlib.h>
#include "lwm2m-object.h"
#include "lwm2m-engine.h"
#include "dev/acc-mag-sensor.h"

//https://github.com/IPSO-Alliance/pub/blob/master/reg/xml/3313.xml

/*---------------------------------------------------------------------------*/

static int
acc_x(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  int value = acc_sensor.value(ACC_MAG_SENSOR_X);
  return ctx->writer->write_int(ctx, outbuf, outsize, value);
}

static int
acc_y(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  int value = acc_sensor.value(ACC_MAG_SENSOR_Y);
  return ctx->writer->write_int(ctx, outbuf, outsize, value);
}

static int
acc_z(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  int value = acc_sensor.value(ACC_MAG_SENSOR_Z);
  return ctx->writer->write_int(ctx, outbuf, outsize, value);
}

/*---------------------------------------------------------------------------*/
LWM2M_RESOURCES(accelerometer_resources,
                LWM2M_RESOURCE_CALLBACK(5702, { acc_x, NULL, NULL }),
                LWM2M_RESOURCE_CALLBACK(5703, { acc_y, NULL, NULL }),
                LWM2M_RESOURCE_CALLBACK(5704, { acc_z, NULL, NULL }),
                /* Units */
                LWM2M_RESOURCE_STRING(5701, "Mg"),
                );
LWM2M_INSTANCES(accelerometer_instances,
                LWM2M_INSTANCE(0, accelerometer_resources));
LWM2M_OBJECT(accelerometer, 3313, accelerometer_instances);
/*---------------------------------------------------------------------------*/

void
object_accelerometer_init(void)
{
  SENSORS_ACTIVATE(acc_sensor);
  lwm2m_engine_register_object(&accelerometer);
}

