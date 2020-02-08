#include "contiki.h"

#include <stdlib.h>
#include "lwm2m-object.h"
#include "lwm2m-engine.h"
#include "dev/leds.h"

//https://github.com/IPSO-Alliance/pub/blob/master/reg/xml/3311.xml

static uint8_t is_on = 1; // true  
static uint8_t led_value = LEDS_GREEN;

static char *
get_color(int value) {
  switch(value) {
  case LEDS_GREEN:
    return "Green";
  case LEDS_RED:
    return "Red";
  case LEDS_BLUE:
    return "Blue";
  }
  return "None";
}

/*---------------------------------------------------------------------------*/

static int
read_color(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  char *value;
  value = get_color(led_value);
  return ctx->writer->write_string(ctx, outbuf, outsize,
                                   value, strlen(value));
}

static int
read_state(lwm2m_context_t *ctx, uint8_t *outbuf, size_t outsize)
{
  return ctx->writer->write_boolean(ctx, outbuf, outsize, is_on ? 1 : 0);
}
/*---------------------------------------------------------------------------*/

static int
write_color(lwm2m_context_t *ctx, const uint8_t *inbuf, size_t insize,
            uint8_t *outbuf, size_t outsize)
{
  char color[20];
  size_t len;
  len = ctx->reader->read_string(ctx, inbuf, insize,
                                 (uint8_t *)&color, sizeof(color));
  printf("Leds color value: %s\n", color);
  if(strncmp(color, "Red", len) == 0) {
    led_value = LEDS_RED;
  } else if(strncmp(color, "Green", len) == 0) {
    led_value = LEDS_GREEN;
  } else if(strncmp(color, "Blue", len) == 0) {
    led_value = LEDS_BLUE;
  }
  return len;
  
}

static int
write_state(lwm2m_context_t *ctx, const uint8_t *inbuf, size_t insize,
            uint8_t *outbuf, size_t outsize)
{
  int value;
  size_t len;

  len = ctx->reader->read_boolean(ctx, inbuf, insize, &value);
  printf("Leds control value: %d\n", value);

  if(len > 0) {
    if (value == 0 && is_on == 1) {
      is_on = 0;
      leds_off(led_value); 
    }
    if (value == 1 && is_on == 0) {
      is_on = 1;
      leds_on(led_value);
    } 
  }
  return len;
}


/*---------------------------------------------------------------------------*/
LWM2M_RESOURCES(leds_control_resources,
                LWM2M_RESOURCE_CALLBACK(5850, { read_state, write_state, NULL }),
                LWM2M_RESOURCE_CALLBACK(5706, { read_color, write_color, NULL }),
                /* Units */
                LWM2M_RESOURCE_STRING(5701, "Lux"),
                );
LWM2M_INSTANCES(leds_control_instances,
                LWM2M_INSTANCE(0, leds_control_resources));
LWM2M_OBJECT(leds_control, 3311, leds_control_instances);

/*---------------------------------------------------------------------------*/

void
object_leds_init(void)
{ 
  leds_on(led_value);
  lwm2m_engine_register_object(&leds_control);
}

