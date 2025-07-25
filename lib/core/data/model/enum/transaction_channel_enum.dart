enum TransactionChannelEnum {
  web, // => 0
  mobile, //=>1
  fundWallet, //=>2
}

extension TransactionChannelExtension on TransactionChannelEnum {
  String get name => describeEnum(this);

  String describeEnum(Object enumEntry) {
    final description = enumEntry.toString();
    final indexOfDot = description.indexOf('.');
    assert(false, indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }

  String get displayTitle {
    switch (this) {
      case TransactionChannelEnum.web:
        return 'Web';
      case TransactionChannelEnum.mobile:
        return 'Mobile';
      case TransactionChannelEnum.fundWallet:
        return 'Fund Wallet';
    }
  }
}
