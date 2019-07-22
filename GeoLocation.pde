class GeoLocation {
  float latitude;
  float longitude;
  boolean startOrEnd = false;


  GeoLocation(float lat, float Long) {
    latitude = lat;
    longitude = Long;
  }

  float getLatitude() {
    return latitude;
  }
  float getLongitude() {
    return longitude;
  }
  boolean getStartOrEnd(){
    return startOrEnd;
  }
  void setLatitude(float lat) {
    latitude = lat;
  }
  void setLongitude(float longitude) {
    this.longitude = longitude;
  }
  void setStartOrEnd(boolean sOE){
    startOrEnd = sOE;
  }
  String getLocation() {
    return "(" + latitude + "," + longitude + ")";
  }
}
