import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:kobo_kobo/core/data/core_data.dart';
import 'package:kobo_kobo/di/dependency_injection_container.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/topUp/top_up.dart';
import 'package:kobo_kobo/features/transfer/transfer.dart';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:permission_handler/permission_handler.dart';

class TransferVm extends ChangeNotifier {
  final tenureDuration = [
    '30 Days',
    '60 Days',
    '90 Days',
    '180 Days',
    '270 Days',
    '365 Days'
  ];

  final savingFrequency = [
    'Daily',
    'Weekly',
    'Monthly',
  ];

  List<ItemClass> items(BuildContext context) => [
        ItemClass(
          title: 'To KoboKobo Account (VFD MFB)',
          subtitle: 'Transfer money to koboKobo account',
          img: koboWhitePng,
          onTap: () {
            koboAccount = true;
            AppNavigator.of(context).push(AppRoutes.koboTransfer,
                args: BankOrKoboAccountTransferArgs(koboAccount: true));
          },
        ),
        ItemClass(
          title: 'To Other Banks',
          subtitle: 'Transfer money to other bank accounts',
          img: bankPng,
          onTap: () {
            koboAccount = false;
            AppNavigator.of(context).push(AppRoutes.bankTransfer,
                args: BankOrKoboAccountTransferArgs(koboAccount: false));
          },
        ),
      ];

  List<ItemClass> items2 = [
    ItemClass(
      title: 'Account Name',
      subtitle: 'Adisa Taiwo Joshua',
    ),
    ItemClass(
      title: 'Account Number',
      subtitle: '0034507169',
    ),
    ItemClass(
      title: 'Amount To Pay',
      subtitle: '160589',
    ),
    ItemClass(
      title: 'Service Charge',
      subtitle: '0035',
    ),
    ItemClass(
      title: 'Description',
      subtitle: 'Refund',
    ),
  ];

  List<ItemClass> items3 = [
    ItemClass(
      title: 'Account Name',
      subtitle: 'Adisa Taiwo Joshua',
    ),
    ItemClass(
      title: 'Account Number',
      subtitle: '0034507169',
    ),
    ItemClass(
      title: 'Bank',
      subtitle: 'GT Bank',
    ),
    ItemClass(
      title: 'Amount To Pay',
      subtitle: '160589',
    ),
    ItemClass(
      title: 'Service Charge',
      subtitle: '0035',
    ),
    ItemClass(
      title: 'Description',
      subtitle: 'Refund',
    ),
  ];

  List<ItemClass> topUpSummary = [
    ItemClass(
      title: 'Top Up',
      subtitle: 'Airtime',
    ),
    ItemClass(
      title: 'Phone Number',
      subtitle: '08066119024',
    ),
    ItemClass(
      title: 'Amount To Pay',
      subtitle: '1500',
    ),
  ];

  bool _showBtmSheet = false;
  bool get showBtmSheet => _showBtmSheet;
  set showBtmSheet(bool value) {
    _showBtmSheet = value;
    notifyListeners();
  }

  bool _koboAccount = true;
  bool get koboAccount => _koboAccount;
  set koboAccount(bool value) {
    _koboAccount = value;
    notifyListeners();
  }

  int? _activeIndex;
  int? get activeIndex => _activeIndex;
  set activeIndex(int? value) {
    _activeIndex = value;
    notifyListeners();
  }

  bool _showSavingsSheet = false;
  bool get showSavingsSheet => _showSavingsSheet;
  set showSavingsSheet(bool value) {
    _showSavingsSheet = value;
    notifyListeners();
  }

  bool _permissionDenied = false;
  bool get permissionDenied => _permissionDenied;
  set permissionDenied(bool val) {
    _permissionDenied = val;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool val) {
    _loading = val;
    notifyListeners();
  }

  Future fetchContacts() async {
    selectedContacts = Contact();
    notifyListeners();
    try {
      if (!await FlutterContacts.requestPermission(readonly: true)) {
        permissionDenied = true;
        notifyListeners();
      } else {
        loading = true;
        notifyListeners();

        await loadContacts();
        loading = false;
        notifyListeners();
      }
    } catch (e) {
      loading = false;
      notifyListeners();
    }
  }

  Future onRetry() async {
    final res = await Permission.contacts.isPermanentlyDenied;
    final granted = await Permission.contacts.isGranted;

    if (!res) {
      if (granted) {
        try {
          loading = true;
          notifyListeners();
          await loadContacts();
          loading = false;
          notifyListeners();
        } catch (e) {
          loading = false;
        }
      } else {
        await openAppSettings();
      }
    } else {
      await openAppSettings();
    }
    notifyListeners();
  }

  Contact _selectedContacts = Contact();
  Contact get selectedContacts => _selectedContacts;
  set selectedContacts(Contact val) {
    _selectedContacts = val;
    notifyListeners();
  }

  List<Contact> _fetchedContacts = [];
  List<Contact> get fetchedContacts => _fetchedContacts;
  set fetchedContacts(List<Contact> val) {
    _fetchedContacts = val;
    notifyListeners();
  }

  Future<void> loadContacts() async {
    loading = true;
    final contactsList = <Contact>[];
    fetchedContacts = [];
    notifyListeners();
    final res = await sl<IContactLocalDataSource>().getContactList();
    if (res != null) {
      final localContactList = jsonDecode(res) as List;
      for (final contact in localContactList) {
        final contactData = Contact.fromJson(contact);
        contactsList.add(contactData);
      }
    } else {
      sl<IContactLocalDataSource>().deleteContactLists();
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      notifyListeners();

      for (final contact in contacts) {
        if (contact.displayName.isNotEmpty && contact.phones.isNotEmpty) {
          contactsList.add(
            contact,
          );
        }
        notifyListeners();
      }
    }

    fetchedContacts = contactsList;
    sl<IContactLocalDataSource>().saveContactLists(fetchedContacts);
    notifyListeners();
    loading = false;
    permissionDenied = false;
    notifyListeners();
  }
}
