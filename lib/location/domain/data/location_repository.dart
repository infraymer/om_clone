import 'package:tinder/location/domain/model/gpoint.dart';
import 'package:tinder/location/domain/remote/location_remote_data_source.dart';

class LocationRepository {
  final LocationRemoteDataSource _locationRemoteDataSource =
      LocationRemoteDataSource();

  Future<void> sendGeoLocation(Gpoint gpoint) =>
      _locationRemoteDataSource.sendGeoLocation(gpoint);
}
