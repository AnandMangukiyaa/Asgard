import 'package:asgard_assignment/views/pages/products/products.dart';
import 'package:asgard_assignment/views/pages/products/products_map_view.dart';
import 'package:asgard_assignment/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:asgard_assignment/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App loads and displays products', (WidgetTester tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Verify that the ProductsPage is displayed
    expect(find.byType(ProductsPage), findsOneWidget);

    // Wait for the location to be loaded
    await tester.pumpAndSettle();

    // Verify that the ProductsMapView is displayed
    expect(find.byType(ProductsMapView), findsOneWidget);

    // Verify that the GoogleMap is displayed
    expect(find.byType(GoogleMap), findsOneWidget);

    // Verify that the list of products is displayed
    expect(find.byType(ProductItem), findsWidgets);
  });
}