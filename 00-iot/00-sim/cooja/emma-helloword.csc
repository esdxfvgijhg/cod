<?xml version="1.0" encoding="UTF-8"?>
<simconf>
  <project EXPORT="discard">[CONTIKI_DIR]/tools/cooja/apps/mrm</project>
  <project EXPORT="discard">[CONTIKI_DIR]/tools/cooja/apps/mspsim</project>
  <project EXPORT="discard">[CONTIKI_DIR]/tools/cooja/apps/avrora</project>
  <project EXPORT="discard">[CONTIKI_DIR]/tools/cooja/apps/serial_socket</project>
  <project EXPORT="discard">[CONTIKI_DIR]/tools/cooja/apps/collect-view</project>
  <project EXPORT="discard">[CONTIKI_DIR]/tools/cooja/apps/powertracker</project>
  <project EXPORT="discard">[CONTIKI_DIR]/tools/cooja/apps/emma-agent-laucher</project>
  <project EXPORT="discard">[CONTIKI_DIR]/tools/cooja/apps/emma-view</project>
  <simulation>
    <title>EMMA</title>
    <randomseed>123456</randomseed>
    <motedelay_us>1000000</motedelay_us>
    <radiomedium>
      se.sics.cooja.radiomediums.UDGM
      <transmitting_range>50.0</transmitting_range>
      <interference_range>100.0</interference_range>
      <success_ratio_tx>1.0</success_ratio_tx>
      <success_ratio_rx>1.0</success_ratio_rx>
    </radiomedium>
    <events>
      <logoutput>40000</logoutput>
    </events>
    <motetype>
      se.sics.cooja.avrmote.RavenMoteType
      <identifier>Raven1</identifier>
      <description>Border Edge Router</description>
      <source EXPORT="discard">/home/slash6475/Documents/research/emma-inst/emma-node/examples/ipv6/rpl-border-router/border-router.c</source>
      <commands EXPORT="discard">make border-router.avr-raven TARGET=avr-raven</commands>
      <firmware EXPORT="copy">/home/slash6475/Documents/research/emma-inst/emma-node/examples/ipv6/rpl-border-router/border-router.avr-raven</firmware>
      <moteinterface>se.sics.cooja.interfaces.Position</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvroraMoteID</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvroraLED</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.RavenRadio</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvroraClock</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvroraUsart0</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvroraUsart1</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvrDebugger</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvroraADC</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.Mote2MoteRelations</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.MoteAttributes</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.RimeAddress</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.IPAddress</moteinterface>
    </motetype>
    <motetype>
      se.sics.cooja.avrmote.RavenMoteType
      <identifier>Raven2</identifier>
      <description>EMMA node</description>
      <source EXPORT="discard">/home/slash6475/Documents/research/emma-inst/emma-node/examples/emma-node-example/emma-node-example.c</source>
      <commands EXPORT="discard">make emma-node-example.avr-raven TARGET=avr-raven</commands>
      <firmware EXPORT="copy">/home/slash6475/Documents/research/emma-inst/emma-node/examples/emma-node-example/emma-node-example.avr-raven</firmware>
      <moteinterface>se.sics.cooja.interfaces.Position</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvroraMoteID</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvroraLED</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.RavenRadio</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvroraClock</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvroraUsart0</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvroraUsart1</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvrDebugger</moteinterface>
      <moteinterface>se.sics.cooja.avrmote.interfaces.AvroraADC</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.Mote2MoteRelations</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.MoteAttributes</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.RimeAddress</moteinterface>
      <moteinterface>se.sics.cooja.interfaces.IPAddress</moteinterface>
    </motetype>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>55.68832558689764</x>
        <y>72.2450504502296</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.avrmote.interfaces.AvroraMoteID
        <id>1</id>
      </interface_config>
      <motetype_identifier>Raven1</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>58.17823780061863</x>
        <y>52.87906656573297</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.avrmote.interfaces.AvroraMoteID
        <id>2</id>
      </interface_config>
      <motetype_identifier>Raven2</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>23.042809895889054</x>
        <y>50.94246817728331</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.avrmote.interfaces.AvroraMoteID
        <id>3</id>
      </interface_config>
      <motetype_identifier>Raven2</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>59.66344790029095</x>
        <y>13.286283839357315</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.avrmote.interfaces.AvroraMoteID
        <id>4</id>
      </interface_config>
      <motetype_identifier>Raven2</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>11.68065068372217</x>
        <y>90.57985856944782</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.avrmote.interfaces.AvroraMoteID
        <id>5</id>
      </interface_config>
      <motetype_identifier>Raven2</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>85.2906152389139</x>
        <y>30.746513554879694</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.avrmote.interfaces.AvroraMoteID
        <id>6</id>
      </interface_config>
      <motetype_identifier>Raven2</motetype_identifier>
    </mote>
    <mote>
      <breakpoints />
      <interface_config>
        se.sics.cooja.interfaces.Position
        <x>21.97219200815107</x>
        <y>10.584510672557347</y>
        <z>0.0</z>
      </interface_config>
      <interface_config>
        se.sics.cooja.avrmote.interfaces.AvroraMoteID
        <id>7</id>
      </interface_config>
      <motetype_identifier>Raven2</motetype_identifier>
    </mote>
  </simulation>
  <plugin>
    SerialSocketServer
    <width>451</width>
    <z>7</z>
    <height>160</height>
    <location_x>682</location_x>
    <location_y>0</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.SimControl
    <width>280</width>
    <z>2</z>
    <height>160</height>
    <location_x>400</location_x>
    <location_y>0</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.Visualizer
    <plugin_config>
      <skin>se.sics.cooja.plugins.skins.IDVisualizerSkin</skin>
      <skin>se.sics.cooja.plugins.skins.GridVisualizerSkin</skin>
      <skin>se.sics.cooja.plugins.skins.TrafficVisualizerSkin</skin>
      <skin>se.sics.cooja.plugins.skins.UDGMVisualizerSkin</skin>
      <skin>se.sics.cooja.plugins.skins.AddressVisualizerSkin</skin>
      <skin>emma.EmmaView</skin>
      <viewport>3.0121543878817287 0.0 0.0 3.0121543878817287 35.42483239630659 31.220087616937402</viewport>
    </plugin_config>
    <width>400</width>
    <z>1</z>
    <height>400</height>
    <location_x>1</location_x>
    <location_y>1</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.LogListener
    <plugin_config>
      <filter />
    </plugin_config>
    <width>731</width>
    <z>5</z>
    <height>240</height>
    <location_x>400</location_x>
    <location_y>160</location_y>
  </plugin>
  <plugin>
    se.sics.cooja.plugins.TimeLine
    <plugin_config>
      <mote>0</mote>
      <mote>1</mote>
      <mote>2</mote>
      <mote>3</mote>
      <mote>4</mote>
      <mote>5</mote>
      <mote>6</mote>
      <showRadioRXTX />
      <showRadioHW />
      <showLEDs />
      <split>-1</split>
      <zoomfactor>500.0</zoomfactor>
    </plugin_config>
    <width>1133</width>
    <z>4</z>
    <height>166</height>
    <location_x>0</location_x>
    <location_y>820</location_y>
  </plugin>
  <plugin>
    Emma
    <width>150</width>
    <z>6</z>
    <height>414</height>
    <location_x>6</location_x>
    <location_y>398</location_y>
  </plugin>
  <plugin>
    EmmaAgentLauncher
    <width>970</width>
    <z>0</z>
    <height>400</height>
    <location_x>159</location_x>
    <location_y>401</location_y>
  </plugin>
  <plugin>
    SerialSocketServer
    <mote_arg>0</mote_arg>
    <width>451</width>
    <z>3</z>
    <height>160</height>
    <location_x>682</location_x>
    <location_y>0</location_y>
  </plugin>
</simconf>

