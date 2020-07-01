// provide ACCESS_COARSE_LOCATION
// provide ACCESS_FINE_LOCATION
// provide ACCESS_LOCATION_EXTRA_COMMANDS
// permissions for running sketch in android 

import ketai.sensors.*; 

double longitude, latitude, altitude;
KetaiLocation location;

void setup() {
  fullScreen();
  orientation(LANDSCAPE);
  location = new KetaiLocation(this);

  textAlign(CENTER, CENTER);
  textSize(displayDensity * 36);
}

void draw() {
  background(78, 93, 75);
  if (location == null  || location.getProvider() == "none")
    text("Location data is unavailable. \n" +
      "Please check your location settings.", 0, 0, width, height);
  else
    text("Latitude: " + latitude + "\n" + 
      "Longitude: " + longitude + "\n" + 
      "Altitude: " + altitude + "\n" + 
      "Provider: " + location.getProvider(), 0, 0, width, height);  
  // getProvider() returns "gps" if GPS is available
  // otherwise "network" (cell network) or "passive" (WiFi MACID)
}

void onLocationEvent(double _latitude, double _longitude, double _altitude)
{
  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
  println("lat/lon/alt: " + latitude + "/" + longitude + "/" + altitude);
}


