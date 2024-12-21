
import 'package:asgard_assignment/models/models.dart';
import 'package:asgard_assignment/views/pages/direction/product_direction_view.dart';
import 'package:asgard_assignment/views/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProductDirectionPage extends StatefulWidget {
  final Product product;
  const ProductDirectionPage(this.product,{Key? key}) : super(key: key);

  @override
  State<ProductDirectionPage> createState() => _ProductDirectionPageState();
}

class _ProductDirectionPageState extends State<ProductDirectionPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backAppBar(context, title: 'Product Direction'),
      body: Column(
        children: [
          Expanded(child: ProductDirectionView(widget.product))
        ],
      ),
    );
  }
}