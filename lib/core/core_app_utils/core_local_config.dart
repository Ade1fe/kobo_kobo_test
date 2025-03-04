import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/di/dependency_injection_container.dart';

enum Flavor { development, production }

class AppEnvManager {
  AppEnvManager(this._flavor);
  final Flavor _flavor;

  static AppEnvManager get instance {
    return sl<AppEnvManager>();
  }

  Flavor getEnvironment() => _flavor;

  bool get envIsTest => _flavor == Flavor.development;
  bool get envIsProd => _flavor == Flavor.production;
}

extension AppConfig on Flavor {
  R fold<R>({
    required R Function(String) ifDevelopment,
    required R Function(String) ifProduction,
  }) {
    switch (this) {
      case Flavor.development:
        return ifDevelopment(Flavor.development.name);

      case Flavor.production:
        return ifProduction(Flavor.production.name);
      // ignore: no_default_cases
      default:
        throw InvalidArgOrDataException();
    }
  }

  static late Map<String, String> _constants;

  static void setEnvironment(Flavor environment) {
    switch (environment) {
      case Flavor.development:
        _constants = _Constants.developmentConstants;
        break;

      case Flavor.production:
        _constants = _Constants.prodConstants;
        break;
    }
  }

  static Map<String, String> get constants {
    return _constants;
  }

  static String get baseUrl {
    return _constants[_Constants.baseUrl]!;
  }

  static String get appName {
    return _constants[_Constants.appName]!;
  }

  static String get flavor {
    return _constants[_Constants.flavor]!;
  }
}

class _Constants {
  static const baseUrl = 'BASE_URL';
  static const appName = 'APP_NAME';
  static const flavor = 'FLAVOR_NAME';

  static Map<String, String> developmentConstants = {
    baseUrl: 'APP_DEV_URL',
    appName: 'KinApp Test',
    flavor: Flavor.development.name,
  };

  static Map<String, String> prodConstants = {
    baseUrl: 'APP_PROD_URL',
    appName: 'KinApp',
    flavor: Flavor.production.name,
  };
}

String throwIfUndefined(String env) {
  final value = dotenv.get(env, fallback: '');
  if (value.isEmpty) {
    throw InvalidArgOrDataException('$env is undefined');
  }
  return value;
}
