#include "contiki.h"

#include <stdlib.h>
#include "lwm2m-object.h"
#include "lwm2m-engine.h"
#include "dev/pressure-sensor.h"

//https://github.com/IPSO-Alliance/pub/blob/master/reg/xml/3323.xml


/*---------------------------------------------------------------------------*/

static int
pres(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  int pressure = pressure_sensor.value(0);
  //pressure = pressure / PRESSURE_SENSOR_VALUE_SCALE;
  return ctx->writer->write_float32fix(ctx, outbuf, outsize,
                                       pressure, LWM2M_FLOAT32_BITS);
}


/*---------------------------------------------------------------------------*/
LWM2M_RESOURCES(pressure_resources,
                /* pressure (Current) */
                LWM2M_RESOURCE_CALLBACK(5700, { pres, NULL, NULL }),
                /* Units */
                LWM2M_RESOURCE_STRING(5701, "Mbar"),
                );
LWM2M_INSTANCES(pressure_instances,
                LWM2M_INSTANCE(0, pressure_resources));
LWM2M_OBJECT(pressure, 3323, pressure_instances);
/*---------------------------------------------------------------------------*/


void
object_pressure_init(void)
{
  SENSORS_ACTIVATE(pressure_sensor);
  /* register this device */
  lwm2m_engine_register_object(&pressure);
}

