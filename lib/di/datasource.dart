import 'package:get_it/get_it.dart';
import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/features/topUp/top_up.dart';

void registerDataSources(GetIt getIt) {
  getIt.registerFactory<IContactLocalDataSource>(
    () => ContactLocalDataSource(
      getIt<SharedPrefLocalCache>(),
    ),
  );
}
