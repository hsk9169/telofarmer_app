import 'package:flutter/material.dart';
import 'package:telofarmer_app/consts/colors.dart';
import 'package:telofarmer_app/routes.dart';
import 'package:telofarmer_app/screens/screens.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.mainMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
      ),
      routes: {
        Routes.SIGNIN: (context) => SignInView(),
        Routes.SIGNUP: (context) => SignUpView(),
        Routes.SERVICE: (context) =>
            ServiceView(ModalRoute.of(context)!.settings.arguments as int),
      },
      initialRoute: Routes.SIGNIN,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
