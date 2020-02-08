# Urban Traffic-light Control in IoT (IoT-UTLC) project

## Project

This project is a proof of concept for a Urban Traffic-light Control in IoT (IoT-UTLC). It uses Contiki Os and Zolertia Re-motes for the Wireless Sensor Network and Paho MQTT and Ubidots for the connection to the Internet and the IoT Cloud Platform.

Its use case is to get a working traffic light crossroad. In addition we implemented the fact that a priority vehicle (police, ambulance...) could interrrupt the cycle of the traffic lights in order to pass its road to green.

The main version is using a Re-motes as a Border Router and a host machine as a middleware to connect to the Internet.
A second version, has been in early development with an Ethernet Router and autonomous Re-motes. It can be found in the `autonomous-border-router` branch.

To set up this project, a wiki page is available, to explain the elements we used and a step-by-step setup.

## Credit

This project has been initiated in a student project at ECE Paris by Jonathan HAUTERVILLE, Sohpie DUBIEF, Pierre BENEDICK, Maxime FAIVRE, Ismail MURAT and Fatih BAYRAM under the supervision of Rafik ZITOUNI. 
It has been continued during and 4-month intership by Jérémy PETIT.