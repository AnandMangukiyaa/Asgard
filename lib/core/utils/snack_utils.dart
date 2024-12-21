part of 'utils.dart';

const double _kElevation = 2;

const SnackBarBehavior _kSnackBarBehavior = SnackBarBehavior.floating;

const Duration _kDuration2000ms = Duration(milliseconds: 2000);

class SnackUtils {
  final BuildContext context;

  SnackUtils(this.context);

  void showSnakBar(String message) {
    var snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.black,
      behavior: _kSnackBarBehavior,
      elevation: _kElevation,
      duration: _kDuration2000ms,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSnak(String message) {
    NavigatorState? state = navigatorKey.currentState;
    if (state != null) {
      OverlayState? overlay = state.overlay;
      if (overlay != null) {
        var snackBar = SnackBar(
          content: Text(message),
          backgroundColor: Colors.black,
          behavior: _kSnackBarBehavior,
          elevation: _kElevation,
        );
        ScaffoldMessenger.of(overlay.context).showSnackBar(snackBar);
      }
    }
  }
}
