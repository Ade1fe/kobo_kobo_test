import 'dart:async';

import 'package:flutter/services.dart';
import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/di/dependency_injection_container.dart' as locator;

import 'package:flutter/material.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';

class AppSetups {
  static Future<void> runSetups({
    Flavor environment = Flavor.development,
    bool enableLogging = false,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    /// load env variables
    // await dotenv.load();

    // init logger
    Log.init();

    // set the environment
    AppConfig.setEnvironment(environment);
    // init service locator => 1
    await locator.initServiceLocator(environment, enableLogging: enableLogging);

    ErrorWidget.builder = (FlutterErrorDetails details) {
      var inDebug = false;
      assert(
        () {
          inDebug = true;
          return true;
        }(),
        '',
      );
      // In debug mode, use the normal error widget which shows
      // the error message:
      if (inDebug) {
        return ErrorWidget(details.exception);
      }
      // In release builds, show a yellow-on-blue message instead:
      return Container(
        alignment: Alignment.center,
        child: Text(
          'Error! ${details.exception}',
          style: const TextStyle(color: Colors.yellow),
          textDirection: TextDirection.ltr,
        ),
      );
    };
    // set default device orientation
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runZonedGuarded(() {
      WidgetsFlutterBinding.ensureInitialized();

      runApp(const ProductApp());
    }, (error, trace) {});
  }
}
