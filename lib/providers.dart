import 'package:get_it/get_it.dart';
import 'package:kobo_kobo/features/bills/bills.dart';
import 'package:kobo_kobo/features/dashboard/dashboard.dart';
import 'package:kobo_kobo/features/onboarding/onboarding.dart';
import 'package:kobo_kobo/features/transfer/presentation/vm/trasnfer_vm.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider<OnboardingVm>(
    create: (_) => GetIt.I<OnboardingVm>(),
  ),
  ChangeNotifierProvider<DashboardVm>(
    create: (_) => GetIt.I<DashboardVm>(),
  ),
  ChangeNotifierProvider<TransferVm>(
    create: (_) => GetIt.I<TransferVm>(),
  ),
  ChangeNotifierProvider<BillsVm>(
    create: (_) => GetIt.I<BillsVm>(),
  ),
];
