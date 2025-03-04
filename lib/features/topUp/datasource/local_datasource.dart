import 'dart:async';
import 'dart:convert';

import 'package:kobo_kobo/core/data/cache/cache.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

abstract class IContactLocalDataSource {
  FutureOr<dynamic> getContactList();
  void saveContactLists(dynamic pref);
  void deleteContactLists();
}

class ContactLocalDataSource implements IContactLocalDataSource {
  ContactLocalDataSource(ILocalCache localCache) : _localCache = localCache;
  final ILocalCache _localCache;

  @override
  FutureOr getContactList() async {
    dynamic defaultPref;
    final pref = await _localCache.get<String>(CacheKeys.contacts);
    if (pref != null) {
      return pref;
    }
    return defaultPref;
  }

  @override
  void saveContactLists(dynamic pref) {
    unawaited(
      _localCache.put(
        CacheKeys.contacts,
        jsonEncode(pref),
      ),
    );
  }

  @override
  void deleteContactLists() {
    unawaited(
      _localCache.remove(
        CacheKeys.contacts,
      ),
    );
  }
}
