#include "contiki.h"

#include "lib/random.h"
#include <stdlib.h>
#include "lwm2m-object.h"
#include "lwm2m-engine.h"
#include "dev/gyr-sensor.h"

//https://github.com/IPSO-Alliance/pub/blob/master/reg/xml/3334.xml

/*---------------------------------------------------------------------------*/

static int
gyro_x(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  int value = gyr_sensor.value(GYR_SENSOR_X);
  return ctx->writer->write_int(ctx, outbuf, outsize, value);
}

static int
gyro_y(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  int value = gyr_sensor.value(GYR_SENSOR_Y);
  return ctx->writer->write_int(ctx, outbuf, outsize, value);
}

static int
gyro_z(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  int value = gyr_sensor.value(GYR_SENSOR_Z);
  return ctx->writer->write_int(ctx, outbuf, outsize, value);
}

/*---------------------------------------------------------------------------*/
LWM2M_RESOURCES(gyrometer_resources,
                LWM2M_RESOURCE_CALLBACK(5702, { gyro_x, NULL, NULL }),
                LWM2M_RESOURCE_CALLBACK(5703, { gyro_y, NULL, NULL }),
                LWM2M_RESOURCE_CALLBACK(5704, { gyro_z, NULL, NULL }),
                /* Units */
                LWM2M_RESOURCE_STRING(5701, "M°/s"),
                );
LWM2M_INSTANCES(gyrometer_instances,
                LWM2M_INSTANCE(0, gyrometer_resources));
LWM2M_OBJECT(gyrometer, 3334, gyrometer_instances);
/*---------------------------------------------------------------------------*/

void
object_gyrometer_init(void)
{
  SENSORS_ACTIVATE(gyr_sensor);
  lwm2m_engine_register_object(&gyrometer);
}

