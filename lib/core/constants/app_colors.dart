part of 'constants.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xff39B54A);

  static const Color backgroundColor = Colors.white;

  static const Color primary10 = Color(0xffE9F4EA);

  static const Color secondary = Color(0xff665687);

  static const Color red = Color(0xffEE6C4D);

  static const Color lightGrey = Color(0xffF9F9F9);

  static const Color darkGrey = Color(0xff828382);

  static const Color lightBlue = Color(0xffA1CBFD);

  static const Color tertiary = Color(0xffBDBDBD);
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: color,
    100: color,
    200: color,
    300: color,
    400: color,
    500: color,
    600: color,
    700: color,
    800: color,
    900: color,
  });
}
