import 'package:location/location.dart';
import 'package:tinder/location/domain/data/location_repository.dart';
import 'package:tinder/location/domain/model/gpoint.dart';

class LocationInteractor {
  final LocationRepository _locationRepository = LocationRepository();

  Future<Gpoint> getCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    final gpoint = Gpoint(_locationData.latitude, _locationData.longitude);

    await _locationRepository.sendGeoLocation(gpoint);

    return gpoint;
  }
}
