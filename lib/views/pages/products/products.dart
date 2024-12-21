import 'package:asgard_assignment/blocs/product_bloc.dart';
import 'package:asgard_assignment/blocs/product_state.dart';
import 'package:asgard_assignment/core/constants/constants.dart';
import 'package:asgard_assignment/core/enums/enums.dart';
import 'package:asgard_assignment/core/routes/app_routes.dart';
import 'package:asgard_assignment/services/services.dart';
import 'package:asgard_assignment/views/pages/pages.dart';
import 'package:asgard_assignment/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
ProductBloc _productBloc = GetIt.I<ProductBloc>();

  @override
  void initState() {
    super.initState();
    _productBloc.getCurrentLocation(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.homeAppBar(context, title: "Products"),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ProductBloc,ProductState>(
              bloc: _productBloc,
              builder: (context,state) {
                return state.locationStatus== ResultStatus.loading?Center(
                  child: CircularProgressIndicator(),
                ): ProductsMapView();
              }
            ),
          ),
        ],
      ),

    );

  }
}
