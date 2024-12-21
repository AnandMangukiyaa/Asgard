part of 'services.dart';

class LocationService {
  LocationService._();

  static Future<LocationResult> getCurrentLocation() async {
    LocationResult result = LocationResult(status: false);
    LocationPermission permission;
    //
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      result.status = false;
      result.message = 'Location permissions are denied';
    }

    if (permission == LocationPermission.deniedForever) {
      result.status = false;
      result.message =
          'Location permissions are permanently denied, we cannot request permissions.';
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        result.status = true;
        result.message =
            'Location service is enabled and permission is granted.';
        result.latitude = position.latitude;
        result.longitude = position.longitude;
      } catch (e) {
        result.status = false;
        result.message = e.toString();
      }
    }

    return result;
  }

  static Stream<LatLng> getPosition() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).map((position) => LatLng(position.latitude, position.longitude));
  }

  static Future<Location?> getLatLngFromAddress(String? address) async {
    List<Location> locations = await locationFromAddress(address ?? '');
    if (locations.isNotEmpty) {
      return locations.first;
    } else {
      return null;
    }
  }

  static Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  static Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }
}

class LocationResult {
  bool status;
  String? message;
  double? latitude;
  double? longitude;

  LocationResult({
    required this.status,
    this.message,
    this.latitude,
    this.longitude,
  });

  @override
  String toString() {
    return 'LocationResult(status: $status, message: $message, latitude: $latitude, longitude: $longitude)';
  }
}
