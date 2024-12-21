part of 'utils.dart';

class MapUtils {
  MapUtils._();

  static const String googleApiKey = 'AIzaSyAsi3XSvcad47GTmV4vJh_novoRVzqEGGQ';

  static const String googleMapUrl =
      'https://www.google.com/maps/search/?api=1&query';

  static const String mapStyle = '''
[
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
]
   ''';

  static String getMapDirectionsUrl({
    required LatLng destination,
    String? destinationTitle,
    LatLng? origin,
    String? originTitle,
    List<LatLng>? waypoints,
    Map<String, String>? extraParams,
  }) {
    return _buildUrl(
      url: 'https://www.google.com/maps/dir/',
      queryParams: {
        'api': '1',
        'destination': '${destination.latitude},${destination.longitude}',
        'origin': _nullOrValue(
          origin,
          '${origin?.latitude},${origin?.longitude}',
        ),
        'dir_action': 'navigate',
        'waypoints': waypoints
            ?.map((coords) => '${coords.latitude},${coords.longitude}')
            .join('|'),
        'travelmode': 'driving',
        ...(extraParams ?? {}),
      },
    );
  }

  static String? _nullOrValue(dynamic nullable, String value) {
    if (nullable == null) return null;
    return value;
  }

  static String _buildUrl({
    required String url,
    required Map<String, String?> queryParams,
  }) {
    return queryParams.entries.fold('$url?', (dynamic previousValue, element) {
      if (element.value == null || element.value == '') {
        return previousValue;
      }
      return '$previousValue&${element.key}=${element.value}';
    }).replaceFirst('&', '');
  }
}
