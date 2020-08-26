import 'package:tinder/location/domain/model/gpoint.dart';
import 'package:tinder/remote/api.dart';

class LocationRemoteDataSource {
  Future<void> sendGeoLocation(Gpoint gpoint) async {
    final result = await dio.post(
      'updateLatLon',
      data: {
        'lat': '${gpoint.lat}',
        'lon': '${gpoint.lon}',
      },
    );
  }
}
