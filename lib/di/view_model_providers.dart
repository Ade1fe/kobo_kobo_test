import 'package:get_it/get_it.dart';
import 'package:kobo_kobo/features/bills/bills.dart';
import 'package:kobo_kobo/features/dashboard/dashboard.dart';
import 'package:kobo_kobo/features/onboarding/onboarding.dart';
import 'package:kobo_kobo/features/transfer/presentation/vm/trasnfer_vm.dart';

void registerViewModelProviders(GetIt getIt) {
  getIt
    ..registerFactory(() => OnboardingVm())
    ..registerFactory(() => DashboardVm())
    ..registerFactory(() => TransferVm())
    ..registerFactory(() => BillsVm());
}
