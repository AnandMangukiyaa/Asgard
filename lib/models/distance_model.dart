part of 'models.dart';

class Distance {
  String? destinationAddresses;
  String? originAddresses;
  String? distance;
  num? distanceValue;
  String? duration;
  num? durationValue;

  Distance({
    this.destinationAddresses,
    this.originAddresses,
    this.distance,
    this.distanceValue,
    this.duration,
    this.durationValue,
  });

  factory Distance.fromMap(Map<String, dynamic> json) {
    var row = (json['rows'] as List).first['elements'];
    var distance = row.first['distance'];
    var duration = row.first['duration'];
    return Distance(
      destinationAddresses: (json['destination_addresses'] as List).first,
      originAddresses: (json['origin_addresses'] as List).first,
      distance: distance != null ? distance['text'] : '-',
      distanceValue: distance != null ? distance['value'] : null,
      duration: duration != null ? duration['text'] : null,
      durationValue: duration != null ? duration['value'] : null,
    );
  }

  @override
  String toString() {
    return 'Distance(destinationAddresses : $destinationAddresses, originAddresses : $originAddresses, distance : $distance, distanceValue : $distanceValue, duration : $duration, durationValue : $durationValue)';
  }
}