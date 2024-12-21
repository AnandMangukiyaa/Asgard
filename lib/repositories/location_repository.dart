import 'dart:developer';

import 'package:asgard_assignment/core/utils/utils.dart';
import 'package:asgard_assignment/models/models.dart';
import 'package:asgard_assignment/models/place_model.dart';
import 'package:asgard_assignment/services/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationRepository {
  final String _baseUrl = 'https://maps.googleapis.com/maps/api';

  final HttpService _http = HttpService();

  Future<List<Place>> getPlaces(String qurey) async {
    List<Place> places = [];

    String url =
        '$_baseUrl/place/autocomplete/json?input=$qurey&types=geocode&key=${MapUtils.googleApiKey}';

    Result result = await _http.request(requestType: RequestType.get, url: url);

    if (result is Success) {
      places = (result.value['predictions'] as List).map((e) {
        return Place.fromMap(e);
      }).toList();
    }
    return places;
  }

  Future<Location?> getLatLng(String? address) async {
    return await LocationService.getLatLngFromAddress(address);
  }

  Future<Distance?> getDistance(
      {required LatLng start, required LatLng end}) async {
    String baseUrl = '$_baseUrl/distancematrix/json';
    String origins = 'origins=${start.latitude}, ${start.longitude}';
    String mode = 'mode=driving';
    String language = 'language=en-EN';
    String sensor = 'sensor=false';
    String destinations = 'destinations=${end.latitude}, ${end.longitude}';
    String key = 'key=${MapUtils.googleApiKey}';

    String url = '$baseUrl?$origins&$destinations&$mode&$language&$sensor&$key';

    Result result = await _http.request(requestType: RequestType.get, url: url);

    if (result is Success) {
      log(result.value.toString(), name: url);
      return Distance.fromMap(result.value);
    }

    return null;
  }
}
