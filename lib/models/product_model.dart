part of 'models.dart';

//Get Product's Model List
List<Product> productFromJson(dynamic str) => List<Product>.from(str.map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String? userId;
  String? id;
  String? title;
  String? body;
  List<double> coordinates;
  String? imageUrl;
  num? distance;

  Product({
    this.userId,
    this.id,
    this.title,
    this.body,
    this.coordinates = const [],
    this.imageUrl,
    this.distance,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
    imageUrl: json["imageUrl"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    "imageUrl": imageUrl,
    "distance": distance,
  };
}
