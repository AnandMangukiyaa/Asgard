import 'dart:async';

import 'package:asgard_assignment/core/constants/constants.dart';
import 'package:asgard_assignment/core/helpers/helpers.dart';
import 'package:asgard_assignment/core/routes/app_routes.dart';
import 'package:asgard_assignment/core/utils/utils.dart';
import 'package:asgard_assignment/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

import 'package:shimmer/shimmer.dart';

part 'widget_delegate.dart';
part 'primary_button.dart';
part 'primary_text_field.dart';
part 'soical_auth_button.dart';
part 'app_bars.dart';
part 'loader.dart';
part 'image_view.dart';
part 'app_tab_bar.dart';
part 'dialog_header.dart';
part 'expanded_section.dart';
part 'primary_text.dart';
part 'marker_with_label.dart';
part 'product_item.dart';
class EmptyWidget extends StatelessWidget {
  final String message;
  const EmptyWidget(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: Sizes.s16.h,
          color: AppColors.darkGrey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
