part of 'utils.dart';

class ThemeUtils {
  ThemeUtils._();

  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primary,
      hintColor: AppColors.darkGrey.withOpacity(0.5),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      fontFamily: AppFontFamily.poppins,
      splashColor: Colors.white.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.1),
      unselectedWidgetColor: Colors.grey.shade400,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.secondary,
        selectionColor: AppColors.secondary.withOpacity(0.1),
        selectionHandleColor: AppColors.secondary,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: generateMaterialColor(AppColors.primary))
          .copyWith(secondary: AppColors.secondary),
    );
  }
}
