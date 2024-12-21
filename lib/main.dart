import 'package:asgard_assignment/core/constants/constants.dart';
import 'package:asgard_assignment/core/routes/app_routes.dart';
import 'package:asgard_assignment/core/utils/utils.dart';
import 'package:asgard_assignment/injector.dart';
import 'package:asgard_assignment/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  Injector.init();

  runApp(const MyApp());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appName,
        navigatorKey: navigatorKey,
        theme: ThemeUtils.theme,
        initialRoute: Routes.product,
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: const ScrollBehaviorModified(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                ScreenUtil.init(
                  constraints,
                  designSize: Size(constraints.maxWidth, constraints.maxHeight),
                );
                return child ?? const SizedBox.shrink();
              },
            ),
          );
        },
    );
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
