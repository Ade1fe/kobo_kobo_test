import 'package:intl/intl.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';

/* Resource for number formatting 
https://www.ablebits.com/office-addins-blog/custom-excel-number-format/
https://symbl.cc/en/unicode/table/#miscellaneous-technical

*/
class Money {
  factory Money([CurrencyModel? currency]) {
    return Money._(currency ?? ngn);
  }

  Money._(CurrencyModel currency)
      : _currency = currency,
        _numberFormat = NumberFormat('#,###.00#', 'en_US'),
        _currencyFormat = NumberFormat.currency(
          name: currency.name,
          symbol: '${currency.shortName} ',
          locale: currency.locale,
          decimalDigits: currency.minorUnits,
        );
  final NumberFormat _currencyFormat;
  final NumberFormat _numberFormat;
  final CurrencyModel _currency;

  /// returns a money instance without currency shortName/symbol
  Money normalized() => Money(_currency.copyWith(shortName: ''));

  /// use this to to get the integral value of a monetary input
  /// Eg usd $1.24 becomes 124 cents and vice versa for Naira to Kobo
  int getValue(num input) => input.round();

  String numFormatV(num input) => _numberFormat.format(input);

  String formatValue(num input) => _currencyFormat.format(input);
  String formatWithCurrencySymbol(
    num input, {
    String? currencyShortName,
    int setDec = 2,
  }) {
    final currencyFormat = NumberFormat.simpleCurrency(
      name: currencyShortName ?? _currency.shortName,
      decimalDigits: setDec, // Set the number of decimal places
    );

    return currencyFormat.format(input);
  }

  int sanitizeAmount(String? value) {
    if (value == null) return 0;
    try {
      value.replaceAll(RegExp('[A-Za-b]+'), '').replaceAll(',', '').trim();
      final sanitizedAmount = getValue(double.parse(value));
      return sanitizedAmount;
    } catch (_) {
      return 0;
    }
  }
}

class CurrencyModel {
  const CurrencyModel({
    required this.name,
    required this.shortName,
    required this.locale,
    required this.minorUnits,
    required this.flag,
  });
  final String name;
  final String shortName;
  final String locale;
  final int minorUnits;
  final String flag;

  CurrencyModel copyWith({
    String? name,
    String? shortName,
    String? locale,
    int? minorUnits,
    String? flag,
  }) {
    return CurrencyModel(
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      locale: locale ?? this.locale,
      minorUnits: minorUnits ?? this.minorUnits,
      flag: flag ?? this.flag,
    );
  }
}

final ngn = CurrencyModel(
  name: 'naira',
  shortName: 'NGN',
  locale: 'en_NG',
  minorUnits:
      2, //https://help.sap.com/doc/d847860d561a47568a936d5f3cbeb9da/4.1/en-US/core_tool/Tools_MENU/Currencies/About_currencies.htm#:~:text=The%20minor%20currency%20unit%20has,have%20no%20minor%20currency%20unit.
  flag: nigeriaSvg,
);

final cad = CurrencyModel(
  name: 'canadian dollars',
  shortName: 'CAD',
  locale: 'en_CA',
  minorUnits: 1,
  flag: canadaSvg,
);

final pound = CurrencyModel(
  name: 'Pound Sterling',
  shortName: 'GBP',
  locale: 'en_GB',
  minorUnits: 1,
  flag: ukSvg,
);

final australianDollar = CurrencyModel(
  name: 'Australian Dollar',
  shortName: 'AUD',
  locale: 'en_GB',
  minorUnits: 1,
  flag: australiaSvg,
);

List<CurrencyModel> supportedCurrencyList() => [ngn, cad, pound];
