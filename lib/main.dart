import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telofarmer_app/widgets/dismiss_keyboard.dart';
import 'package:provider/provider.dart';
import 'package:telofarmer_app/providers/platform_provider.dart';
import 'package:telofarmer_app/providers/session_provider.dart';
import 'package:telofarmer_app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // fix screen rotation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(DismissKeyboard(
        child: MultiProvider(providers: [
      ChangeNotifierProvider<Session>.value(value: Session()),
      ChangeNotifierProvider<Platform>.value(value: Platform()),
    ], child: MyApp())));
  });
}
