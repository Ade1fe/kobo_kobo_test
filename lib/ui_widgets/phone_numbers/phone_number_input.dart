import 'dart:convert';

import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

class PhoneNumber extends Equatable {
  const PhoneNumber({
    required this.number,
    required this.dialCode,
  });

  factory PhoneNumber.fromJson(String source) =>
      PhoneNumber.fromMap(json.decode(source));

  factory PhoneNumber.fromMap(Map<String, dynamic> map) {
    return PhoneNumber(
      number: map['number'] ?? '',
      dialCode: map['dialCode'] ?? '',
    );
  }

  factory PhoneNumber.empty() => const PhoneNumber(
        number: '',
        dialCode: '',
      );
  final String number;
  final String dialCode;

  bool get isNotEmpty => this != PhoneNumber.empty();

  Map<String, dynamic> toMap() =>
      {'phoneNumber': number, 'countryCode': dialCode};

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props => [number, dialCode];
}

List<CountryData> phoneNumberCountryList() => [
      CountryData.empty().copyWith(
        countryName: 'Nigeria',
        countryId: 'NG',
        mobileCountryCode: '+234',
        flag: nigeriaSvg,
        currencyCode: 'NGN',
        maxLength: 11,
      ),
      CountryData.empty().copyWith(
        countryName: 'Canada',
        countryId: 'CA',
        mobileCountryCode: '+1',
        flag: canadaSvg,
        currencyCode: 'CAD',
        maxLength: 10,
      ),
      CountryData.empty().copyWith(
        countryName: 'United Kingdom',
        countryId: 'UK',
        mobileCountryCode: '+44',
        flag: ukSvg,
        currencyCode: 'GBP',
        maxLength: 11,
      ),
      CountryData.empty().copyWith(
        countryName: 'Australia',
        countryId: 'AU',
        mobileCountryCode: '+66',
        flag: australiaSvg,
        currencyCode: 'AUD',
        maxLength: 10,
      ),
    ];

List<TextInputFormatter> amountInputFormatters(Money money) => [
      LengthLimitingTextInputFormatter(18),
      FilteringTextInputFormatter.digitsOnly,
      AmountInputFormatter(money),
    ];

class AmountInputFormatter extends TextInputFormatter {
  AmountInputFormatter(this.money);
  final Money money;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) return TextEditingValue.empty;
    final valueAsDouble = newValue.text.toDouble();
    final string = money.formatValue(valueAsDouble);
    return TextEditingValue(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}
