import 'dart:async';

import 'package:asgard_assignment/blocs/product_bloc.dart';
import 'package:asgard_assignment/blocs/product_state.dart';
import 'package:asgard_assignment/core/constants/constants.dart';
import 'package:asgard_assignment/core/enums/enums.dart';
import 'package:asgard_assignment/core/utils/utils.dart';
import 'package:asgard_assignment/models/models.dart';
import 'package:asgard_assignment/services/services.dart';
import 'package:asgard_assignment/views/dialogs/app_dialogs.dart';
import 'package:asgard_assignment/views/pages/products/app_lifecycle_reactor.dart';
import 'package:asgard_assignment/views/widgets/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class ProductsMapView extends StatefulWidget {
  const ProductsMapView({Key? key}) : super(key: key);

  @override
  State<ProductsMapView> createState() => _ProductsMapViewState();
}

class _ProductsMapViewState extends State<ProductsMapView> {
  // Google Map controller
  GoogleMapController? _googleMapController;

  // Map settings
  final double _zoom = 10;
  final double _tilt = 0;
  final double _bearing = 0;


  //Markers
  final List<Marker> _markers = [];
  //Product Bloc instance
  final ProductBloc _productBloc = GetIt.I<ProductBloc>();

  // Method to handle map creation
  Future<void> _onMapCreated(GoogleMapController controller) async {
    //Create product markers icon
    final Map<String, Uint8List> _cachedIcons = {};
      for (var product in _productBloc.products) {
        if (!_cachedIcons.containsKey(product.id)) {
          Uint8List? icon = await MarkersWithLabel.getBytesFromCanvasDynamic(
            iconPath: AppAssets.marker,
            plateReg: product.title!,
            fontSize: Sizes.s48.sp,
            iconSize: Size(Sizes.s100.w, Sizes.s140.w),
          );
          _cachedIcons[product.id!] = icon!;
        }
      }

    // Get the current location icon
    Uint8List? _currentLocation =
    await _getBytesFromAsset(AppAssets.currentLocation, 100);

    setState(() {
      // Set GoogleMapController and Map Style
      _googleMapController = controller;
      _googleMapController?.setMapStyle(MapUtils.mapStyle);


      //Add the current location marker
      if (_productBloc.currentLatLng != null) {
        _markers.add(
          Marker(
            markerId: const MarkerId('Current Location'),
            position: _productBloc.currentLatLng ?? const LatLng(0, 0),
            infoWindow: const InfoWindow(title: 'Your Current Location',snippet: 'You are here'),
            icon: _currentLocation != null
                ? BitmapDescriptor.fromBytes(_currentLocation)
                : BitmapDescriptor.defaultMarker,
            rotation: 0,
          ),
        );
      }

      //Add the product markers
      for (var product in _productBloc.products) {
        _markers.add(
          Marker(
            markerId: MarkerId(product.id!.toString()),
            position: LatLng(product.coordinates.first, product.coordinates.last),
            infoWindow: InfoWindow(title: product.title),
            icon: BitmapDescriptor.fromBytes(_cachedIcons[product.id]!),
            onTap: () async {
              AppDialogs.showDetailDialog(context, product);
            },
          ),
        );
      }
    });
  }


  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc,ProductState>(
      bloc: _productBloc,
      builder: (context, state) {
        return AppLifecycleReactor(
          onHandleAppLifecycle: (lifeCycleState) {
            if (lifeCycleState == AppLifecycleState.resumed) {
              _productBloc.getCurrentLocation(false);
              if (mounted) {
                setState(() {
                  _updateCurrentLocation();
                  // _setPolylines();
                });
              }
            }
          },
          child:Column(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _productBloc.currentLatLng ?? const LatLng(0.0, 0.0),
                        zoom: _zoom,
                        tilt: _tilt,
                        bearing: _bearing,
                      ),
                      onMapCreated: _onMapCreated,
                      markers: Set.from(_markers),
                      indoorViewEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationEnabled: false,
                      buildingsEnabled: true,
                      myLocationButtonEnabled: false,
                      compassEnabled: false,
                      mapToolbarEnabled: false,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: Sizes.s16.w,bottom: Sizes.s16.h),
                        child: FloatingActionButton(
                          onPressed: (){
                            _googleMapController?.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(target: _productBloc.currentLatLng ?? const LatLng(0.0, 0.0), zoom: 10.0),
                              ),
                            );
                          },
                          backgroundColor: Colors.white,
                          child: Icon(Icons.location_on,color: Colors.black,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                  child: SizedBox(
                    child: state.status == ResultStatus.loading?Center(
                      child: CircularProgressIndicator(),
                    ):ListView.separated(itemBuilder: (ctx,index){
                      return GestureDetector(
                        onTap: (){
                          _googleMapController?.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(target: LatLng(_productBloc.products[index].coordinates.first,_productBloc.products[index].coordinates.last,), zoom: 10.0),
                            ),
                          );                    },
                          child: ProductItem(product: _productBloc.products[index]));
                    }, separatorBuilder: (ctx,index){
                      return SizedBox(height: Sizes.s8.h);
                    }, itemCount: _productBloc.products.length),
                  ))
            ],
          ),
        );
      },
    );
  }

  // Update driver current location marker
  Future<void> _updateCurrentLocation() async {


    Uint8List? _currentLocation =
        await _getBytesFromAsset(AppAssets.currentLocation, 100);

    if (_productBloc.currentLatLng != null &&
        _productBloc.products.isNotEmpty) {
      double? _zoomLevel = await _googleMapController?.getZoomLevel();
      CameraPosition cPosition = CameraPosition(
        zoom: _zoomLevel ?? _zoom,
        tilt: _tilt,
        bearing: _bearing,
        target: _productBloc.currentLatLng ?? const LatLng(0.0, 0.0),
      );
      _googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cPosition));

      _markers.removeWhere((m) => m.markerId.value == 'Current Location');
      _markers.add(
        Marker(
          markerId: const MarkerId('Current Location'),
          position: _productBloc.currentLatLng ?? const LatLng(0, 0),
          infoWindow: const InfoWindow(title: 'Your Current Location'),
          icon: _currentLocation != null
              ? BitmapDescriptor.fromBytes(_currentLocation)
              : BitmapDescriptor.defaultMarker,
          rotation: 0,
        ),
      );
    }
  }

  // Method to get bytes from asset
  Future<Uint8List?> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }
}
