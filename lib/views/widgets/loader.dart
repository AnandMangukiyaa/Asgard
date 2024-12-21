part of 'widgets.dart';

const double _kPadding = 20.0;

const double _kBorderRadius = 10.0;

const double _kLoaderSize = 45.0;

class Loader {
  Loader._();

  static Widget circularProgressIndicator([double size = _kLoaderSize]) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          backgroundColor: Colors.grey.shade300,
        ),
      ),
    );
  }

  static void show(BuildContext context) {
    Navigator.push(context, _LoaderDialog());
  }

  static void dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}

class _LoaderDialog extends PopupRoute {
  @override
  Color? get barrierColor => Colors.black12;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => 'Loader Dialog';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: barrierColor,
            ),
            Container(
              padding: const EdgeInsets.all(_kPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_kBorderRadius),
              ),
              child: const SizedBox(
                height: _kLoaderSize,
                width: _kLoaderSize,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  backgroundColor: AppColors.lightGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
