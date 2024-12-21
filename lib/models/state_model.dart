part of 'models.dart';

class Land {
  final String? stateId;
  final String? stateName;

  Land({this.stateId, this.stateName});

  factory Land.fromMap(Map<String, dynamic> data) {
    return Land(stateId: data['state_id'], stateName: data['state_name']);
  }

  Map<String, dynamic> toMap() {
    return {'state_id': stateId, 'state_name': stateName};
  }
}

class City {
  final String? stateId;
  final String? cityId;
  final String? cityName;

  City({this.stateId, this.cityId, this.cityName});

  factory City.fromMap(Map<String, dynamic> data) {
    return City(
      stateId: data['state_id'],
      cityId: data['city_id'],
      cityName: data['city_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'state_id': stateId, 'city_id': cityId, 'city_name': cityName};
  }
}
