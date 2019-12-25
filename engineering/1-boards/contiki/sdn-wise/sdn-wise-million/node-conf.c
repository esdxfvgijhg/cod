#include "node-conf.h"
#include "address.h"
#include "net/rime/rime.h"
#include <string.h>

#define _MY_ADDRESS 1
#define _NET 1
// Million Beacon period modified to 10, and report period to 20
#define _BEACON_PERIOD 5
//#define _BEACON_PERIOD	10
//#define _REPORT_PERIOD	10
#define _REPORT_PERIOD 20
#define _RULE_TTL 100
#define _RSSI_MIN 0
#define _PACKET_TTL 100;

#define DEBUG 1
#if DEBUG && (!SINK || DEBUG_SINK)
#include <stdio.h>
#define PRINTF(...) printf(__VA_ARGS__)
#else
#define PRINTF(...)
#endif
/*----------------------------------------------------------------------------*/
node_conf_t conf;
/*----------------------------------------------------------------------------*/
void node_conf_init(void) {

#if COOJA
	conf.my_address.u8[1] = linkaddr_node_addr.u8[0];
	conf.my_address.u8[0] = linkaddr_node_addr.u8[1];
	// Million A: Use static address
//#else
// conf.my_address = get_address_from_int(_MY_ADDRESS);
#endif
	conf.requests_count = 0;
	conf.my_net = _NET;
	conf.beacon_period = _BEACON_PERIOD;
	conf.report_period = _REPORT_PERIOD;
	conf.rule_ttl = _RULE_TTL;
	conf.rssi_min = _RSSI_MIN;
	conf.packet_ttl = _PACKET_TTL;
#if SINK
	// Million A. Static address added SINK = 0.1
	conf.my_address.u8[0] = 1;
	conf.my_address.u8[1] = 0;
	conf.is_active = 1;
	conf.nxh_vs_sink = conf.my_address;
	conf.sink_address = conf.my_address;
	;
	conf.hops_from_sink = 0;
	// conf.rssi_from_sink = 255;
	conf.rssi_from_sink = 0;
#endif
#if NODE1
	// Million A. static adderess added NODE = 0.5
	conf.my_address.u8[0] = 2;
	conf.my_address.u8[1] = 0;
	conf.sink_address.u8[0] = 1;
	conf.sink_address.u8[1] = 0;
	conf.nxh_vs_sink = conf.sink_address;
	// upto this are Million additions
	conf.is_active = 0;
	// Million commented out the next two lines, because broadcast address changes
	// address of sink and nxh_vs_sink set_broadcast_address(&(conf.nxh_vs_sink));
	// set_broadcast_address(&(conf.sink_address));
	conf.hops_from_sink = _PACKET_TTL;
	// conf.rssi_from_sink = 0; original vaue
	conf.rssi_from_sink = 100;
#endif
#if NODE2
	// Million A. static adderess added NODE = 0.5
	conf.my_address.u8[0] = 3;
	conf.my_address.u8[1] = 0;
	conf.sink_address.u8[0] = 1;
	conf.sink_address.u8[1] = 0;
	conf.nxh_vs_sink = conf.sink_address;
	// upto this are Million additions
	conf.is_active = 0;
	// Million commented out the next two lines, because broadcast address changes
	// address of sink and nxh_vs_sink set_broadcast_address(&(conf.nxh_vs_sink));
	// set_broadcast_address(&(conf.sink_address));
	conf.hops_from_sink = _PACKET_TTL;
	conf.rssi_from_sink = 100;
#endif
#if NODE3
	// Million A. static adderess added NODE = 0.5
	conf.my_address.u8[0] = 4;
	conf.my_address.u8[1] = 0;
	conf.sink_address.u8[0] = 1;
	conf.sink_address.u8[1] = 0;
	conf.nxh_vs_sink = conf.sink_address;
	// upto this are Million additions
	conf.is_active = 0;
	// Million commented out the next two lines, because broadcast address changes
	// address of sink and nxh_vs_sink set_broadcast_address(&(conf.nxh_vs_sink));
	// set_broadcast_address(&(conf.sink_address));
	conf.hops_from_sink = _PACKET_TTL;
	conf.rssi_from_sink = 100;
#endif
#if NODE4
	// Million A. static adderess added NODE = 0.5
	conf.my_address.u8[0] = 5;
	conf.my_address.u8[1] = 0;
	conf.sink_address.u8[0] = 1;
	conf.sink_address.u8[1] = 0;
	conf.nxh_vs_sink = conf.sink_address;
	// upto this are Million additions
	conf.is_active = 0;
	// Million commented out the next two lines, because broadcast address changes
	// address of sink and nxh_vs_sink set_broadcast_address(&(conf.nxh_vs_sink));
	// set_broadcast_address(&(conf.sink_address));
	conf.hops_from_sink = _PACKET_TTL;
	conf.rssi_from_sink = 100;
#endif
#if NODE5
	// Million A. static adderess added NODE = 0.5
	conf.my_address.u8[0] = 6;
	conf.my_address.u8[1] = 0;
	conf.sink_address.u8[0] = 1;
	conf.sink_address.u8[1] = 0;
	conf.nxh_vs_sink = conf.sink_address;
	// upto this are Million additions
	conf.is_active = 0;
	// Million commented out the next two lines, because broadcast address changes
	// address of sink and nxh_vs_sink set_broadcast_address(&(conf.nxh_vs_sink));
	// set_broadcast_address(&(conf.sink_address));
	conf.hops_from_sink = _PACKET_TTL;
	conf.rssi_from_sink = 100;
#endif
#if NODE6
	// Million A. static adderess added NODE = 0.5
	conf.my_address.u8[0] = 7;
	conf.my_address.u8[1] = 0;
	conf.sink_address.u8[0] = 1;
	conf.sink_address.u8[1] = 0;
	conf.nxh_vs_sink = conf.sink_address;
	// upto this are Million additions
	conf.is_active = 0;
	// Million commented out the next two lines, because broadcast address changes
	// address of sink and nxh_vs_sink set_broadcast_address(&(conf.nxh_vs_sink));
	// set_broadcast_address(&(conf.sink_address));
	conf.hops_from_sink = _PACKET_TTL;
	conf.rssi_from_sink = 100;
#endif
#if NODE7
	// Million A. static adderess added NODE = 0.5
	conf.my_address.u8[0] = 8;
	conf.my_address.u8[1] = 0;
	conf.sink_address.u8[0] = 1;
	conf.sink_address.u8[1] = 0;
	conf.nxh_vs_sink = conf.sink_address;
	// upto this are Million additions
	conf.is_active = 0;
	// Million commented out the next two lines, because broadcast address changes
	// address of sink and nxh_vs_sink set_broadcast_address(&(conf.nxh_vs_sink));
	// set_broadcast_address(&(conf.sink_address));
	conf.hops_from_sink = _PACKET_TTL;
	conf.rssi_from_sink = 100;
#endif
#if NODE8
	// Million A. static adderess added NODE = 0.5
	conf.my_address.u8[0] = 9;
	conf.my_address.u8[1] = 0;
	conf.sink_address.u8[0] = 1;
	conf.sink_address.u8[1] = 0;
	conf.nxh_vs_sink = conf.sink_address;
	// upto this are Million additions
	conf.is_active = 0;
	// Million commented out the next two lines, because broadcast address changes
	// address of sink and nxh_vs_sink set_broadcast_address(&(conf.nxh_vs_sink));
	// set_broadcast_address(&(conf.sink_address));
	conf.hops_from_sink = _PACKET_TTL;
	conf.rssi_from_sink = 100;
#endif
#if NODE9
	// Million A. static adderess added NODE = 0.10
	conf.my_address.u8[0] = 10;
	conf.my_address.u8[1] = 0;
	conf.sink_address.u8[0] = 1;
	conf.sink_address.u8[1] = 0;
	conf.nxh_vs_sink = conf.sink_address;
	// upto this are Million additions
	conf.is_active = 0;
	// Million commented out the next two lines, because broadcast address changes
	// address of sink and nxh_vs_sink set_broadcast_address(&(conf.nxh_vs_sink));
	// set_broadcast_address(&(conf.sink_address));
	conf.hops_from_sink = _PACKET_TTL;
	conf.rssi_from_sink = 100;
#endif
#if NODE10
	// Million A. static adderess added NODE = 0.11
	conf.my_address.u8[0] = 11;
	conf.my_address.u8[1] = 0;
	conf.sink_address.u8[0] = 1;
	conf.sink_address.u8[1] = 0;
	conf.nxh_vs_sink = conf.sink_address;
	// upto this are Million additions
	conf.is_active = 0;
	// Million commented out the next two lines, because broadcast address changes
	// address of sink and nxh_vs_sink set_broadcast_address(&(conf.nxh_vs_sink));
	// set_broadcast_address(&(conf.sink_address));
	conf.hops_from_sink = _PACKET_TTL;
	conf.rssi_from_sink = 100;
#endif
}
/*----------------------------------------------------------------------------*/
void print_node_conf(void) {
	PRINTF("[CFG]: NODE: ");
	print_address(&(conf.my_address));
	PRINTF("\n");
	PRINTF("[CFG]: - Network ID: %d\n[CFG]: - Beacon Period: %d\n[CFG]: - "
				 "Report Period: %d\n[CFG]: - Rules TTL: %d\n[CFG]: - Min RSSI: "
				 "%d\n[CFG]: - Packet TTL: %d\n[CFG]: - Next Hop -> Sink: ",
				 conf.my_net, conf.beacon_period, conf.report_period, conf.rule_ttl,
				 conf.rssi_min, conf.packet_ttl);
	print_address(&(conf.nxh_vs_sink));
	PRINTF(" (hops: %d, rssi: %d)\n", conf.hops_from_sink, conf.rssi_from_sink);
	PRINTF("[CFG]: - Sink: ");
	print_address(&(conf.sink_address));
	PRINTF("\n");
}
/*----------------------------------------------------------------------------*/
/** @} */
