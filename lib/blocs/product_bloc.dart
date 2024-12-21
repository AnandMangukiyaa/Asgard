import 'package:asgard_assignment/blocs/product_state.dart';
import 'package:asgard_assignment/core/enums/enums.dart';
import 'package:asgard_assignment/core/utils/utils.dart';
import 'package:asgard_assignment/models/models.dart';
import 'package:asgard_assignment/repositories/location_repository.dart';
import 'package:asgard_assignment/repositories/product_repository.dart';
import 'package:asgard_assignment/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProductBloc extends Cubit<ProductState> {
  ProductBloc() : super(ProductState());
  ProductRepository _repository = GetIt.I<ProductRepository>();
  LocationRepository _locationRepository = GetIt.I<LocationRepository>();
  LatLng? _currentLatLng;

  LatLng? get currentLatLng => _currentLatLng;

  List<Product> _products = [];

  List<Product> get products => _products;

//This is where we will add the methods to get the current location
  Future<void> getCurrentLocation([bool showLoading = true]) async {
    LocationResult result = LocationResult(status: false);
    try {
      if (showLoading)  emit(state.copyWith(locationStatus: ResultStatus.loading));

      // This will get the current location
      result = await LocationService.getCurrentLocation();

      // If the result is successful, we will set the current latitude and longitude
      if (result.status) {
        if (result.latitude != null && result.longitude != null) {
          _currentLatLng =
              LatLng(result.latitude ?? 0.0, result.longitude ?? 0.0);
          getProducts();
          emit(state.copyWith(locationResult: result, locationStatus: ResultStatus.success));
        }
      } else {
        emit(state.copyWith(locationResult: result, locationStatus: ResultStatus.failure));
      }
    } finally {
      emit(state.copyWith(locationResult: result, locationStatus: ResultStatus.failure));

    }
  }

  // This is where we will add the methods to get the products
  Future<void> getProducts() async {
    try {
      // This will set the status of the state to loading
      emit(state.copyWith(status: ResultStatus.loading));

      // This will check if the device is connected to the internet
      if (await ConnectivityService.isConnected) {
        // This will get the products from the repository
        final products = await _repository.getProducts();
        _products.clear();
         for(Product product in products) {
           print("Product : ${product.toJson()}");
           if (product.coordinates.isNotEmpty) {
             Distance? distance = await _locationRepository.getDistance(start: _currentLatLng!, end: LatLng(product.coordinates.first, product.coordinates.last));
             product.distance = (distance?.distanceValue ?? 1)/1000 ;
           }
           print("Product : ${product.toJson()}");
           _products.add(product);
         }
        // If the products are empty, we will set the status to failure
        if (products.isEmpty) {
          emit(state.copyWith(status: ResultStatus.failure, error: 'No products found'));
          return;
        }

        // If the products are not empty, we will set the status to success
        emit(state.copyWith(status: ResultStatus.success, products: _products));
      } else {
        SnackUtils.showSnak("NO INTERNET CONNECTION");
      }
    } catch (e) {
      // If there is an error, we will set the status to failure
      emit(state.copyWith(status: ResultStatus.failure, error: 'Something went wrong'));
    }
  }
}
