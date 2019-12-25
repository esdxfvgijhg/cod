#include "contiki.h"

#include "lib/random.h"
#include <stdlib.h>
#include "lwm2m-object.h"
#include "lwm2m-engine.h"

//https://github.com/IPSO-Alliance/pub/blob/master/reg/xml/3303.xml

#ifndef TEMPERATURE_MIN
#define TEMPERATURE_MIN (-50 * LWM2M_FLOAT32_FRAC)
#endif

#ifndef TEMPERATURE_MAX
#define TEMPERATURE_MAX (80 * LWM2M_FLOAT32_FRAC)
#endif

/*---------------------------------------------------------------------------*/

static int
temp(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  float scale = rand() / (float) RAND_MAX; /* [0, 1.0] */
  float value = TEMPERATURE_MIN + scale *
	        (TEMPERATURE_MAX - TEMPERATURE_MIN); /* [min, max] */
  return ctx->writer->write_float32fix(ctx, outbuf, outsize,
                                       (int32_t)value, LWM2M_FLOAT32_BITS);
}


/*---------------------------------------------------------------------------*/
LWM2M_RESOURCES(temperature_resources,
                /* Temperature (Current) */
                LWM2M_RESOURCE_CALLBACK(5700, { temp, NULL, NULL }),
                /* Min Range Value */
                LWM2M_RESOURCE_FLOATFIX(5603, TEMPERATURE_MIN),
                /* Max Range Value */
                LWM2M_RESOURCE_FLOATFIX(5604, TEMPERATURE_MAX),
                /* Units */
                LWM2M_RESOURCE_STRING(5701, "Cel"),
                );
LWM2M_INSTANCES(temperature_instances,
                LWM2M_INSTANCE(0, temperature_resources));
LWM2M_OBJECT(temperature, 3303, temperature_instances);
/*---------------------------------------------------------------------------*/

void
object_temperature_handle(void)
{
  printf("Notify observer temperature sensor\n");
  lwm2m_object_notify_observers(&temperature, "/0/5700");
}

void
object_temperature_init(void)
{
  /* register this device */
  lwm2m_engine_register_object(&temperature);
}

