import 'dart:io';

import 'package:asgard_assignment/core/enums/enums.dart';
import 'package:asgard_assignment/core/routes/arguments.dart';
import 'package:asgard_assignment/models/models.dart';
import 'package:asgard_assignment/views/pages/pages.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String product = '/products';
  static const String direction = '/direction';
}

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case Routes.product:
        return MaterialPageRoute(builder: (_) => const ProductsPage());
      case Routes.direction:
        return MaterialPageRoute(builder: (_) => ProductDirectionPage(args as Product));
      default:
        return null;
    }
  }
}
