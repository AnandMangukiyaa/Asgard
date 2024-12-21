import 'package:flutter_test/flutter_test.dart';
import 'package:asgard_assignment/models/models.dart';
import 'package:asgard_assignment/repositories/product_repository.dart';

void main() {
  group('ProductRepository', () {
    late ProductRepository productRepository;

    setUp(() {
      productRepository = ProductRepository();
    });

    test('getProducts returns a list of products', () async {
      List<Product> products = await productRepository.getProductsForTesting();
      expect(products, isA<List<Product>>());
      expect(products.length, greaterThan(0));
    });

    test('getProducts returns correct product data', () async {
      List<Product> products = await productRepository.getProductsForTesting();
      expect(products[0].title, 'break');
    });

    test('getProducts handles exceptions gracefully', () async {
      // Simulate an error by modifying the repository to throw an exception
      productRepository = ProductRepositoryWithError();
      List<Product> products = await productRepository.getProductsForFailureTesting();
      expect(products, isEmpty);
    });
  });
}

class ProductRepositoryWithError extends ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    throw Exception('Simulated error');
  }
}