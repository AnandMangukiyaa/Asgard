import 'dart:io';

import 'package:asgard_assignment/core/constants/constants.dart';
import 'package:asgard_assignment/core/routes/app_routes.dart';
import 'package:asgard_assignment/core/utils/utils.dart';
import 'package:asgard_assignment/models/models.dart';
import 'package:asgard_assignment/services/services.dart';
import 'package:asgard_assignment/views/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

part 'product_detail_dialog.dart';
class AppDialogs {
  AppDialogs._();

  static Future<void> showDetailDialog(BuildContext context,
      Product product) {
    return ProductDetailDialog.show(context, product);
  }


}
