<?xml version="1.0" encoding="UTF-8"?>
<simconf>
  <project EXPORT="discard">[APPS_DIR]/mrm</project>
  <project EXPORT="discard">[APPS_DIR]/mspsim</project>
  <project EXPORT="discard">[APPS_DIR]/avrora</project>
  <project EXPORT="discard">[APPS_DIR]/serial_socket</project>
  <project EXPORT="discard">[APPS_DIR]/collect-view</project>
  <project EXPORT="discard">[APPS_DIR]/powertracker</project>
  <project EXPORT="discard">[CONFIG_DIR]/../sdn-wise/sdn-wise-emulated</project>
  <simulation>
    <title>SDN-WISE</title>
    <speedlimit>1.0</speedlimit>
    <randomseed>123456</randomseed>
    <motedelay_us>1000000</motedelay_us>
    <radiomedium>
      org.contikios.cooja.radiomediums.UDGM
      <transmitting_range>50.0</transmitting_range>
      <interference_range>100.0</interference_range>
      <success_ratio_tx>1.0</success_ratio_tx>
      <success_ratio_rx>1.0</success_ratio_rx>
    </radiomedium>
    <events>
      <logoutput>40000</logoutput>
    </events>
    <motetype>
      org.contikios.cooja.sdnwise.SdnWiseSinkType
      <identifier>apptype1</identifier>
      <description>SDN-WISE Emulated Sink</description>
      <motepath>[CONFIG_DIR]/../sdn-wise/sdn-wise-emulated/build</motepath>
      <moteclass>org.contikios.cooja.sdnwise.CoojaSink</moteclass>
    </motetype>
    <motetype>
      org.contikios.cooja.sdnwise.SdnWiseMoteType
      <identifier>apptype2</identifier>
      <description>SDN-WISE Emulated Mote</description>
      <motepath>[CONFIG_DIR]/../sdn-wise/sdn-wise-emulated/build</motepath>
      <moteclass>org.contikios.cooja.sdnwise.CoojaMote</moteclass>
    </motetype>
    <mote>
      <interface_config>
        org.contikios.cooja.motes.AbstractApplicationMoteType$SimpleMoteID
        <id>1</id>
      </interface_config>
      <interface_config>
        org.contikios.cooja.interfaces.Position
        <x>55.62530741606964</x>
        <y>64.88394379961578</y>
        <z>0.0</z>
      </interface_config>
      <motetype_identifier>apptype1</motetype_identifier>
    </mote>
    <mote>
      <interface_config>
        org.contikios.cooja.motes.AbstractApplicationMoteType$SimpleMoteID
        <id>2</id>
      </interface_config>
      <interface_config>
        org.contikios.cooja.interfaces.Position
        <x>54.5095541382319</x>
        <y>38.86668312913401</y>
        <z>0.0</z>
      </interface_config>
      <motetype_identifier>apptype2</motetype_identifier>
    </mote>
    <mote>
      <interface_config>
        org.contikios.cooja.motes.AbstractApplicationMoteType$SimpleMoteID
        <id>3</id>
      </interface_config>
      <interface_config>
        org.contikios.cooja.interfaces.Position
        <x>76.60854086558486</x>
        <y>64.8288824742831</y>
        <z>0.0</z>
      </interface_config>
      <motetype_identifier>apptype2</motetype_identifier>
    </mote>
    <mote>
      <interface_config>
        org.contikios.cooja.motes.AbstractApplicationMoteType$SimpleMoteID
        <id>4</id>
      </interface_config>
      <interface_config>
        org.contikios.cooja.interfaces.Position
        <x>45.842543516757836</x>
        <y>54.93913382635366</y>
        <z>0.0</z>
      </interface_config>
      <motetype_identifier>apptype2</motetype_identifier>
    </mote>
    <mote>
      <interface_config>
        org.contikios.cooja.motes.AbstractApplicationMoteType$SimpleMoteID
        <id>5</id>
      </interface_config>
      <interface_config>
        org.contikios.cooja.interfaces.Position
        <x>65.66487301966956</x>
        <y>28.895777798948444</y>
        <z>0.0</z>
      </interface_config>
      <motetype_identifier>apptype2</motetype_identifier>
    </mote>
    <mote>
      <interface_config>
        org.contikios.cooja.motes.AbstractApplicationMoteType$SimpleMoteID
        <id>6</id>
      </interface_config>
      <interface_config>
        org.contikios.cooja.interfaces.Position
        <x>60.13224219489539</x>
        <y>64.91697858255229</y>
        <z>0.0</z>
      </interface_config>
      <motetype_identifier>apptype2</motetype_identifier>
    </mote>
  </simulation>
  <plugin>
    org.contikios.cooja.plugins.SimControl
    <width>280</width>
    <z>0</z>
    <height>160</height>
    <location_x>485</location_x>
    <location_y>12</location_y>
  </plugin>
  <plugin>
    org.contikios.cooja.plugins.Visualizer
    <plugin_config>
      <moterelations>true</moterelations>
      <skin>org.contikios.cooja.plugins.skins.IDVisualizerSkin</skin>
      <skin>org.contikios.cooja.plugins.skins.GridVisualizerSkin</skin>
      <skin>org.contikios.cooja.plugins.skins.TrafficVisualizerSkin</skin>
      <skin>org.contikios.cooja.plugins.skins.UDGMVisualizerSkin</skin>
      <skin>org.contikios.cooja.plugins.skins.MoteTypeVisualizerSkin</skin>
      <skin>org.contikios.cooja.plugins.skins.LEDVisualizerSkin</skin>
      <skin>org.contikios.cooja.plugins.skins.AddressVisualizerSkin</skin>
      <skin>org.contikios.cooja.plugins.skins.PositionVisualizerSkin</skin>
      <skin>org.contikios.cooja.plugins.skins.AttributeVisualizerSkin</skin>
      <skin>org.contikios.cooja.plugins.skins.LogVisualizerSkin</skin>
      <viewport>2.1191685556984163 0.0 0.0 2.1191685556984163 123.8985895162163 73.9563557781869</viewport>
    </plugin_config>
    <width>470</width>
    <z>1</z>
    <height>400</height>
    <location_x>1</location_x>
    <location_y>1</location_y>
  </plugin>
  <plugin>
    org.contikios.cooja.plugins.LogListener
    <plugin_config>
      <filter />
      <formatted_time />
      <coloring />
    </plugin_config>
    <width>360</width>
    <z>2</z>
    <height>240</height>
    <location_x>737</location_x>
    <location_y>181</location_y>
  </plugin>
  <plugin>
    org.contikios.cooja.plugins.TimeLine
    <plugin_config>
      <mote>0</mote>
      <mote>1</mote>
      <mote>2</mote>
      <mote>3</mote>
      <mote>4</mote>
      <mote>5</mote>
      <showRadioRXTX />
      <showRadioHW />
      <showLEDs />
      <zoomfactor>500.0</zoomfactor>
    </plugin_config>
    <width>760</width>
    <z>5</z>
    <height>166</height>
    <location_x>0</location_x>
    <location_y>827</location_y>
  </plugin>
  <plugin>
    org.contikios.cooja.plugins.Notes
    <plugin_config>
      <notes>Enter notes here</notes>
      <decorations>true</decorations>
    </plugin_config>
    <width>418</width>
    <z>4</z>
    <height>160</height>
    <location_x>922</location_x>
    <location_y>4</location_y>
  </plugin>
  <plugin>
    org.contikios.cooja.plugins.RadioLogger
    <plugin_config>
      <split>199</split>
      <formatted_time />
      <showdups>false</showdups>
      <hidenodests>false</hidenodests>
    </plugin_config>
    <width>941</width>
    <z>3</z>
    <height>300</height>
    <location_x>243</location_x>
    <location_y>450</location_y>
  </plugin>
</simconf>

