import 'package:asgard_assignment/core/enums/enums.dart';
import 'package:asgard_assignment/models/models.dart';
import 'package:asgard_assignment/services/services.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  final List<Product> products;
  final ResultStatus status;
  final String message;
  final ResultStatus locationStatus;
  final LocationResult? locationResult;

  ProductState({
    this.products = const [],
    this.status=ResultStatus.none,
    this.locationStatus=ResultStatus.none,
    this.message = '',
    this.locationResult,
  });

// To Update the state of the product
  ProductState copyWith({
    List<Product>? products,
    ResultStatus? status,
    ResultStatus? locationStatus,
    String? error,
    LocationResult? locationResult,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      locationStatus: locationStatus ?? this.locationStatus,
      message: error ?? this.message,
      locationResult: locationResult ?? this.locationResult,
    );
  }

  @override
  List<Object?> get props => [products, status, message,locationStatus,locationResult];
}