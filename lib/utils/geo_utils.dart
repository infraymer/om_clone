import 'package:maps_toolkit/maps_toolkit.dart';

class GeoUtils {
  static int distanceBetweenPointsKm(LatLng firstPoint, LatLng secondPoint) {
    int distanceBetweenPoints =
        (SphericalUtil.computeDistanceBetween(firstPoint, secondPoint) / 1000)
            .round();

    return distanceBetweenPoints;
  }
}
