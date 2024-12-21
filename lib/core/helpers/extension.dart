part of 'helpers.dart';

extension ShimmerExtensions on Widget {
  //
  Widget toShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.1),
      highlightColor: Colors.grey.withOpacity(0.18),
      child: this,
    );
  }
}

extension LatLngExtensions on LatLng {
  //
  String toMapUrl() {
    return '${MapUtils.googleMapUrl}=$latitude,$longitude';
  }
}
