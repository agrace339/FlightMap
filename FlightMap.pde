import java.util.*;
import java.nio.file.*;
import java.nio.charset.StandardCharsets;

PImage map;

void setup() {
  final File folder = new File("./documents/Processing/FlightMap/GoodData");
  final List<File> fileList = Arrays.asList(folder.listFiles());

  List<GeoLocation> location = new ArrayList<GeoLocation>();

  for (int i=0; i < fileList.size(); i++) {
    readGeoLocationFromCSV(fileList.get(i).toPath(), location);
  }
  println(location.size());

  map = loadImage("USA.png");

  size(1139, 613);
  image(map, 0, 0);
  stroke(#FF0000);
  strokeWeight(1);

  for (int j = 0; j<location.size(); j++) {
    
    try {
      GeoLocation g = location.get(j);
      float x = lonToUnit(g.getLongitude());
      float y = latToUnit(g.getLatitude());
      
      point(x, y);
    }
    catch(ArithmeticException a) {
    }
  }
  println("done");
}

float lonToUnit(float lon) {
  if (lon == 0) {
    throw new ArithmeticException("longitude is 0");
  }
  return map(lon, -124.804688, -66.972656, 0, width);
}

float latToUnit(float lat) {
  if (lat == 0) {
    throw new ArithmeticException("latitude is 0");
  }
  return map(lat, 49.355992, 24.528697, 0, height);
}

List<GeoLocation> readGeoLocationFromCSV(Path filePath, List<GeoLocation> location) { 

  try {
    BufferedReader br = Files.newBufferedReader(filePath, StandardCharsets.US_ASCII); 
    String line = br.readLine();
    while (line != null) {
      String[] attributes = line.split(","); 
      GeoLocation loc = createLocation(attributes); 
      location.add(loc);
      line = br.readLine();
    }
    location.get(location.size()-1).setStartOrEnd(true);
  }
  catch (IOException ioe) {
  } 
  return location;
}

GeoLocation createLocation(String[] metadata) {
  try {
    float lat = Float.parseFloat(metadata[4]);
    float lon = Float.parseFloat(metadata[5]);

    return new GeoLocation(lat, lon);
  }
  catch(Exception n) {
    return new GeoLocation(0, 0);
  }
}
