
import 'package:asgard_assignment/blocs/product_bloc.dart';
import 'package:asgard_assignment/repositories/product_repository.dart';
import 'package:asgard_assignment/repositories/location_repository.dart';
import 'package:get_it/get_it.dart';

class Injector {
  Injector._();

  static void init() {

    // Repositories
    GetIt.I.registerFactory(() => LocationRepository());
    GetIt.I.registerFactory(() => ProductRepository());
    GetIt.I.registerLazySingleton((){
      return ProductBloc();
    });

  }
}
