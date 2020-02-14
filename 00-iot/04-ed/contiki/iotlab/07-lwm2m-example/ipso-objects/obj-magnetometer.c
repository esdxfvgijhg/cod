#include "contiki.h"

#include "lib/random.h"
#include <stdlib.h>
#include "lwm2m-object.h"
#include "lwm2m-engine.h"
#include "dev/acc-mag-sensor.h"

//https://github.com/IPSO-Alliance/pub/blob/master/reg/xml/3314.xml

/*---------------------------------------------------------------------------*/

static int
mag_x(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  int value = mag_sensor.value(ACC_MAG_SENSOR_X);
  return ctx->writer->write_int(ctx, outbuf, outsize, value);
}

static int
mag_y(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  int value = mag_sensor.value(ACC_MAG_SENSOR_Y);
  return ctx->writer->write_int(ctx, outbuf, outsize, value);
}

static int
mag_z(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  int value = mag_sensor.value(ACC_MAG_SENSOR_Z);
  return ctx->writer->write_int(ctx, outbuf, outsize, value);
}

/*---------------------------------------------------------------------------*/
LWM2M_RESOURCES(magnetometer_resources,
                LWM2M_RESOURCE_CALLBACK(5702, { mag_x, NULL, NULL }),
                LWM2M_RESOURCE_CALLBACK(5703, { mag_y, NULL, NULL }),
                LWM2M_RESOURCE_CALLBACK(5704, { mag_z, NULL, NULL }),
                /* Units */
                LWM2M_RESOURCE_STRING(5701, "Mgauss"),
                );
LWM2M_INSTANCES(magnetometer_instances,
                LWM2M_INSTANCE(0, magnetometer_resources));
LWM2M_OBJECT(magnetometer, 3314, magnetometer_instances);
/*---------------------------------------------------------------------------*/

void
object_magnetometer_init(void)
{
  SENSORS_ACTIVATE(mag_sensor);
  lwm2m_engine_register_object(&magnetometer);
}

