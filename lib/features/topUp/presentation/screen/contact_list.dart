import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/features/transfer/transfer.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:provider/provider.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  late final TextEditingController _searchController;
  List<Contact> _searchList = [];
  late TransferVm vm;

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchController.addListener(_searchListener);
    super.initState();
  }

  void _searchListener() {
    var searchList = <Contact>[];

    final query = _searchController.text.trim().toLowerCase();

    if (query.isNotEmpty) {
      final recipients = vm.fetchedContacts;
      searchList = recipients
          .where(
            (recipient) =>
                recipient.displayName.toLowerCase().contains(query) ||
                (recipient.phones.isNotEmpty &&
                    recipient.phones.first.number
                        .toLowerCase()
                        .contains(query)),
          )
          .toList();
    }

    setState(() => _searchList = searchList);
  }

  @override
  Widget build(BuildContext context) {
    vm = context.watch<TransferVm>();

    return AppScaffoldWidget(
      appBar: const CustomAppBar(showLeading: true),
      body: Column(
        children: [
          if (vm.fetchedContacts.isNotEmpty)
            SearchTextInputField(
              controller: _searchController,
              onChanged: (_) {},
            ),
          YBox(Insets.dim_12.h),
          Expanded(
            child: ListView.separated(
              itemCount: _searchList.isNotEmpty
                  ? _searchList.length
                  : vm.fetchedContacts.length,
              separatorBuilder: (context, index) => YBox(Insets.dim_8.h),
              itemBuilder: (context, index) {
                final recipient = _searchList.isNotEmpty
                    ? _searchList[index]
                    : vm.fetchedContacts[index];
                return GestureDetector(
                  onTap: () {
                    vm.selectedContacts = recipient;
                    AppNavigator.of(context).pop();
                  },
                  child: localContactWidget(
                    context,
                    recipient,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget localContactWidget(
    BuildContext context,
    Contact contact,
  ) {
    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.white,
      elevation: 0.5,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Insets.dim_12,
          horizontal: Insets.dim_8,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.black.withOpacity(0.4)),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: Insets.dim_48.h,
              width: Insets.dim_48.w,
              decoration: BoxDecoration(
                color: Color.fromARGB(
                  32,
                  math.Random().nextInt(256),
                  math.Random().nextInt(256),
                  math.Random().nextInt(256),
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  contact.displayName.getInitials(),
                  style: context.textTheme.bodyMedium.size(14).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            const XBox(Insets.dim_14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.displayName.intelligentTrim(20),
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withOpacity(0.88),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const YBox(Insets.dim_2),
                if (contact.phones.isNotEmpty)
                  Text(
                    contact.phones.first.number,
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.black.withOpacity(0.65),
                    ),
                  ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
