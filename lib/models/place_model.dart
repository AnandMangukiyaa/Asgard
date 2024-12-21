class Place {
  String? description;
  String? placeId;
  String? secondaryText;

  Place({this.description, this.placeId, this.secondaryText});

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      description: map['description'],
      placeId: map['place_id'],
      secondaryText: map['structured_formatting']['secondary_text'],
    );
  }

  @override
  String toString() {
    return 'Place(description: $description, placeId: $placeId, secondaryText: $secondaryText)';
  }
}
