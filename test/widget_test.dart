import 'package:asgard_assignment/core/enums/enums.dart';
import 'package:asgard_assignment/main.dart';
import 'package:asgard_assignment/repositories/location_repository.dart';
import 'package:asgard_assignment/repositories/product_repository.dart';
import 'package:asgard_assignment/views/pages/products/products_map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:asgard_assignment/views/pages/products/products.dart';
import 'package:asgard_assignment/blocs/product_bloc.dart';
import 'package:asgard_assignment/blocs/product_state.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  setUp(() {
    // Register the ProductBloc with GetIt
    GetIt.I.registerFactory(() => LocationRepository());
    GetIt.I.registerFactory(() => ProductRepository());
    GetIt.I.registerLazySingleton((){
      return ProductBloc();
    });
  });

  tearDown(() {
    // Unregister the ProductBloc
    GetIt.I.reset();
  });

  testWidgets('ProductsMapView displays GoogleMap', (WidgetTester tester) async {
    // Arrange
    final productBloc = GetIt.I<ProductBloc>();
    productBloc.emit(ProductState(locationStatus: ResultStatus.success));

    // Act
    await tester.pumpWidget(
      MyApp()
    );

    // Assert
    expect(find.byType(ProductsPage), findsOneWidget);
  });
}