
#define SOFTWARE_SERIAL_GPS
#ifdef HARDWARE_SERIAL_GPS
#define gps_serial Serial
#endif
#ifdef SOFTWARE_SERIAL_GPS
#include <SoftwareSerial.h>
SoftwareSerial gps_serial(4, 3);
#endif
char GPSBuffer[150];
byte GPSIndex = 0;
double gps_latitude = 0.0;
double gps_longitude = 0.0;
char lat_direction, lgt_direction;
void parseNMEA() {
  char inByte;
  bool detect_new_line = false;
  while (!detect_new_line) {
    if (gps_serial.available()) {
      inByte = gps_serial.read();
      if ((inByte == '$') || (GPSIndex >= 150)) {
        GPSIndex = 0;
      }
      if (inByte != '\r' && inByte != '\n') {
        GPSBuffer[GPSIndex++] = inByte;
      }
      if (inByte == '\n') {
        GPSBuffer[GPSIndex++] = '\0';
        detect_new_line = true;
      }
    }
  }
  Serial.print("---->");
  Serial.println(GPSBuffer);
}
bool isGGA() { return (GPSBuffer[1] == 'G' && (GPSBuffer[2] == 'P' || GPSBuffer[2] == 'N') && GPSBuffer[3] == 'G' && GPSBuffer[4] == 'G' && GPSBuffer[5] == 'A'); }
void decodeGGA() {
  int i, j;
  char latitude[30], longitude[30];
  byte latIndex = 0, lgtIndex = 0;
  for (i = 7, j = 0; (i < GPSIndex) && (j < 9); i++) {
    if (GPSBuffer[i] == ',') {
      j++;
    } else {
      if (j == 1) {
        latitude[latIndex++] = GPSBuffer[i];
      } else if (j == 2) {
        lat_direction = GPSBuffer[i];
      } else if (j == 3) {
        longitude[lgtIndex++] = GPSBuffer[i];
      } else if (j == 4) {
        lgt_direction = GPSBuffer[i];
      }
    }
  }
  gps_latitude = degree_location(atof(latitude), lat_direction);
  gps_longitude = degree_location(atof(longitude), lgt_direction);
}
bool isValidLocation() { return (gps_latitude != 0.0 && gps_longitude != 0.0 && (lat_direction == 'N' || lat_direction == 'S') && (lgt_direction == 'E' || lgt_direction == 'W')); }
void display_location() {
  Serial.println("==============");
  Serial.print("Location: ");
  Serial.print(gps_latitude, 5);
  Serial.print(", ");
  Serial.println(gps_longitude, 5);
  Serial.println("==============");
}
double degree_location(double loc, char loc_direction) {
  double degLoc = 0.0;
  double degWhole = loc / 100;
  double degDec = (degWhole - ((int)degWhole)) * 100 / 60;
  degLoc = (int)degWhole + degDec;
  if (loc_direction == 'S' || loc_direction == 'W') {
    degLoc = (-1) * degLoc;
  }
  return degLoc;
}
void setup() {
  Serial.begin(38400);
#ifdef SOFTWARE_SERIAL_GPS
  gps_serial.begin(9600);
#endif
  Serial.println("GPS basic rogram");
}
void loop() {
  bool get_fix = false;
  while (!get_fix) {
    parseNMEA();
    if (isGGA()) {
      decodeGGA();
      if (isValidLocation()) {
        display_location();
        get_fix = true;
      }
    }
  }
}
