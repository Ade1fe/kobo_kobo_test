import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/di/datasource.dart';
import 'package:kobo_kobo/di/repositories.dart';
import 'package:kobo_kobo/di/usecase.dart';
import 'package:kobo_kobo/di/view_model_providers.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator(
  Flavor flavor, {
  bool enableLogging = true,
}) async {
  // register data sources
  registerDataSources(sl);

  // register repositories
  registerRepositories(sl);

  // register view models
  registerViewModelProviders(sl);

  //storage
  _registerStorage();

  // register others
  await _registerOthers(flavor, enableLogging);

  registerUseCases(sl);
}

// Any other class
Future<void> _registerOthers(Flavor flavor, bool enableLogging) async {
  const secureStorage = FlutterSecureStorage();
  final localAuth = LocalAuthentication();
  final connectivity = Connectivity();

  final sharePreference = await SharedPreferences.getInstance();

  sl
    ..registerFactory<SharedPreferences>(() => sharePreference)
    ..registerSingleton(AppEnvManager(flavor))
    ..registerSingleton(secureStorage)
    ..registerSingleton(localAuth)
    ..registerSingleton(connectivity)
    ..registerSingleton(AnalyticsManager())
    ..registerSingleton(
      HttpManager(
        cache: sl<SecureLocalCache>(),
        baseUrl: AppConfig.baseUrl,
        enableLogging: enableLogging,
      ),
    )
    ..registerSingleton(NetworkManager(sl()));
}

void _registerStorage() {
  sl
    ..registerFactory<SharedPrefLocalCache>(() => SharedPrefLocalCache(sl()))
    ..registerFactory<SecureLocalCache>(() => SecureLocalCache(sl()));
}
