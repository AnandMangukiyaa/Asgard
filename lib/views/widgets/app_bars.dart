part of 'widgets.dart';

class AppBars {
  AppBars._();

  static PreferredSize homeAppBar(BuildContext context,
      {required String title}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false,
        title: Text(
          title,
          style: TextStyle(
            fontSize: Sizes.s18.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: Sizes.s1 / 2,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
    );
  }

  static PreferredSize backAppBar(BuildContext context,
      {required String title, List<Widget> actions = const []}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          title,
          style: TextStyle(
            fontSize: Sizes.s16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leadingWidth: 60,
        centerTitle: true,
        actions: actions,
      ),
    );
  }
}
