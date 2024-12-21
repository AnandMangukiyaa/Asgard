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

class ProductDirectionView extends StatefulWidget {
  final Product product;
  const ProductDirectionView(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductDirectionView> createState() => _ProductDirectionViewState();
}

class _ProductDirectionViewState extends State<ProductDirectionView> {
  //Google Map controller
  GoogleMapController? _googleMapController;

  //Subscription to listen to location changes
  StreamSubscription? _locationSubscription;

  // Map settings
  final double _zoom = 11;
  final double _tilt = 0;
  final double _bearing = 0;

  //Polyline points and coordinates
  final PolylinePoints _polylinePoints = PolylinePoints();
  final List<LatLng> _polylineCoordinates = [];

  //Markers and Polylines
  final List<Marker> _markers = [];
  final Set<Polyline> _polylines = {};

  //Product Bloc instance
  final ProductBloc _productBloc = GetIt.I<ProductBloc>();

  @override
  void initState() {
    super.initState();
    //Get the current location
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _locationSubscription = LocationService.getPosition().listen((position) {
        var latlng = LatLng(position.latitude, position.longitude);
        if (mounted) {
          setState(() {
            _updateCurrentLocation();
            _setPolylines();
          });
        }
      }, cancelOnError: true);
    });
  }

  // Method to handle map creation
  Future<void> _onMapCreated(GoogleMapController controller) async {
    //Create product markers icon
    Uint8List? productLocation = await MarkersWithLabel.getBytesFromCanvasDynamic(iconPath: AppAssets.marker, plateReg: widget.product.title!, fontSize: Sizes.s48.sp, iconSize: Size(Sizes.s100.w, Sizes.s140.w));


 // Get the current location icon
    Uint8List? _currentLocation = await _getBytesFromAsset(AppAssets.currentLocation, 100);
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
            infoWindow: const InfoWindow(title: 'Your Current Location', snippet: 'You are here'),
            icon: _currentLocation != null ? BitmapDescriptor.fromBytes(_currentLocation) : BitmapDescriptor.defaultMarker,
            rotation: 0,
          ),
        );
      }

      //Add the product markers
      _markers.add(
        Marker(
          markerId: MarkerId(widget.product.id!.toString() ?? ''),
          position: LatLng(widget.product.coordinates.first, widget.product.coordinates.last),
          infoWindow: InfoWindow(title: widget.product.title ?? ''),
          icon: BitmapDescriptor.fromBytes(productLocation!),
          rotation: 0,
          onTap: () async {
            AppDialogs.showDetailDialog(context, widget.product);
          },
        ),
      );

      // Set Polylines
      _setPolylines();
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _locationSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
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
          child: Column(
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
                      polylines: _polylines,
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
                        padding: EdgeInsets.only(right: Sizes.s16.w, bottom: Sizes.s16.h),
                        child: FloatingActionButton(
                          onPressed: () {
                            _googleMapController?.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(target: _productBloc.currentLatLng ?? const LatLng(0.0, 0.0), zoom: 10.0),
                              ),
                            );
                          },
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to set polylines
  Future<void> _setPolylines() async {

    // Get the route between the current location and the product location
    PolylineResult? result = await _polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: MapUtils.googleApiKey,
      request: PolylineRequest(origin: PointLatLng(_productBloc.currentLatLng!.latitude, _productBloc.currentLatLng!.longitude), destination: PointLatLng(widget.product.coordinates.first, widget.product.coordinates.last), mode: TravelMode.driving),
    );
    _polylineCoordinates.clear();

    // Add the polyline coordinates
    for (var point in result.points) {
      _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }

    // Add the polyline to the map
    _polylines.add(
      Polyline(
        polylineId: PolylineId(_productBloc.currentLatLng!.toString()),
        visible: true,
        points: _polylineCoordinates,
        color: AppColors.primary,
        jointType: JointType.round,
        patterns: [PatternItem.dash(5)],
        width: 5,
      ),
    );

    // _productBloc.getDistance();
  }

  // Update driver current location marker
  Future<void> _updateCurrentLocation() async {
    Uint8List? _currentLocation = await _getBytesFromAsset(AppAssets.currentLocation, 100);

    if (_productBloc.currentLatLng != null && _productBloc.products.isNotEmpty) {
      double? _zoomLevel = await _googleMapController?.getZoomLevel();
      CameraPosition cPosition = CameraPosition(
        zoom: _zoomLevel ?? _zoom,
        tilt: _tilt,
        bearing: _bearing,
        target: _productBloc.currentLatLng ?? const LatLng(0.0, 0.0),
      );
      _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(cPosition));

      _markers.removeWhere((m) => m.markerId.value == 'Current Location');
      _markers.add(
        Marker(
          markerId: const MarkerId('Current Location'),
          position: _productBloc.currentLatLng ?? const LatLng(0, 0),
          infoWindow: const InfoWindow(title: 'Your Current Location'),
          icon: _currentLocation != null ? BitmapDescriptor.fromBytes(_currentLocation) : BitmapDescriptor.defaultMarker,
          rotation: 0,
        ),
      );
    }
  }

  // Get the image bytes from asset
  Future<Uint8List?> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }
}
