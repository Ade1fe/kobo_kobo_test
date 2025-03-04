import 'package:flutter/material.dart';
import 'package:kobo_kobo/features/bills/bills.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:kobo_kobo/ui_widgets/constants/constants.dart';

class BillsVm extends ChangeNotifier {
  final List<BillsOptionModel> _billsOptions = [
    BillsOptionModel(
      name: 'Buy Airtime',
      icon: buyAirtime,
      route: AppRoutes.topUp,
      color: AppColors.airtimeColor,
    ),
    BillsOptionModel(
      name: 'Buy Data',
      icon: buyData,
      route: AppRoutes.topUp,
      color: AppColors.dataColor,
    ),
    BillsOptionModel(
      name: 'Cable Tv',
      icon: cableTv,
      route: AppRoutes.billOptions,
      color: AppColors.cableColor,
    ),
    BillsOptionModel(
      name: 'Electricity',
      icon: electricity,
      route: AppRoutes.billOptions,
      color: AppColors.electricityColor,
    ),
    BillsOptionModel(
      name: 'Internet Subscription',
      icon: internet,
      route: '/internet',
      color: AppColors.internetColor,
    ),
    BillsOptionModel(
      name: 'Sports and Games',
      icon: sports,
      route: '/internet',
      color: AppColors.sportsColor,
    ),
  ];

  final List<BillsOptionModel> _cableOptions = [
    BillsOptionModel(
      name: 'DSTV',
      icon: dstv,
      route: AppRoutes.billOptionsChoice,
      color: AppColors.dstvColor,
    ),
    BillsOptionModel(
      name: 'GOTV',
      icon: gotv,
      route: AppRoutes.billOptionsChoice,
      color: AppColors.gotvColor,
    ),
    BillsOptionModel(
      name: 'Showmax',
      icon: showmax,
      route: AppRoutes.billOptionsChoice,
      color: AppColors.black,
    ),
    BillsOptionModel(
      name: 'Startimes',
      icon: startimes,
      route: AppRoutes.billOptionsChoice,
      color: AppColors.startimes,
    ),
  ];

  final List<BillsOptionModel> _eleOptions = [
    BillsOptionModel(
      name: 'ABUJA DISCO',
      icon: aedc,
      route: AppRoutes.electricityOptionsInputs,
      color: AppColors.electricityColor1,
    ),
    BillsOptionModel(
      name: 'EKEDC',
      icon: ekedc,
      route: AppRoutes.electricityOptionsInputs,
      color: AppColors.electricityColor2,
    ),
    BillsOptionModel(
      name: 'IBEDC',
      icon: ibedc,
      route: AppRoutes.electricityOptionsInputs,
      color: AppColors.electricityColor3,
    ),
    BillsOptionModel(
      name: 'IKEDC',
      icon: ikedc,
      route: AppRoutes.electricityOptionsInputs,
      color: AppColors.electricityColor4,
    ),
    BillsOptionModel(
      name: 'PORT-HARCOURT DISCO',
      icon: phdc,
      route: AppRoutes.electricityOptionsInputs,
      color: AppColors.electricityColor5,
    ),
  ];

  List<BillsOptionModel> get billsOptions => _billsOptions;
  List<BillsOptionModel> get cableOptions => _cableOptions;
  List<BillsOptionModel> get eleOptions => _eleOptions;

  List<BillsOptionModel> _filteredOptions = [];
  List<BillsOptionModel> get filteredOptions => _filteredOptions;

  void filterOptions(String query) {
    if (query.isEmpty) {
      _filteredOptions = _billsOptions;
    } else {
      _filteredOptions = _billsOptions
          .where((option) =>
              option.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
