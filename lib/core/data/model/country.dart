import 'dart:convert';

import 'package:equatable/equatable.dart';

class CountryData extends Equatable {
  const CountryData({
    required this.countryName,
    required this.countryId,
    required this.flag,
    required this.currencyCode,
    required this.slug,
    required this.applicationType,
    required this.mobileCountryCode,
    required this.maxLength,
    required this.exchangeRate,
    this.loqateIso2,
    this.accountMaxLength,
    this.accountMinLength,
  });

  factory CountryData.fromJson(String source) =>
      CountryData.fromMap(json.decode(source));

  factory CountryData.fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) return CountryData.empty();

    return CountryData(
      applicationType: json['applicationType'] ?? 0,
      countryId: json['countryId'] ?? '',
      countryName: json['countryName'] ?? '',
      mobileCountryCode: json['mobileCountryCode'] ?? '',
      currencyCode: json['currencyCode'] ?? '',
      flag: json['flag'] ?? '',
      slug: json['slug'] ?? '',
      maxLength: json['maxLength'] ?? 0,
      accountMaxLength: json['accountMaxLength'] ?? 0,
      accountMinLength: json['accountMinLength'] ?? 0,
      exchangeRate: json['exchangeRate'] ?? 0,
      loqateIso2: json['loqateIso2'] ?? 'CA',
    );
  }

  factory CountryData.empty() => const CountryData(
        countryId: '',
        countryName: '',
        currencyCode: '',
        flag: '',
        slug: '',
        applicationType: 0,
        mobileCountryCode: '',
        maxLength: 0,
        exchangeRate: 0,
        loqateIso2: '',
      );

  CountryData copyWith({
    String? countryName,
    String? countryId,
    String? flag,
    String? currencyCode,
    String? slug,
    int? applicationType,
    String? mobileCountryCode,
    int? maxLength,
    int? accountMaxLength,
    int? accountMinLength,
    double? exchangeRate,
    String? loqateIso2,
  }) {
    return CountryData(
      applicationType: applicationType ?? this.applicationType,
      countryId: countryId ?? this.countryId,
      countryName: countryName ?? this.countryName,
      mobileCountryCode: mobileCountryCode ?? this.mobileCountryCode,
      currencyCode: currencyCode ?? this.currencyCode,
      flag: flag ?? this.flag,
      slug: slug ?? this.slug,
      maxLength: maxLength ?? this.maxLength,
      accountMaxLength: accountMaxLength ?? this.accountMaxLength,
      accountMinLength: accountMinLength ?? this.accountMinLength,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      loqateIso2: loqateIso2 ?? this.loqateIso2,
    );
  }

  Map<String, dynamic> toJson() => {
        'countryName': countryName,
        'countryId': countryId,
        'currencyCode': currencyCode,
        'flag': flag,
        'slug': slug,
        'applicationType': applicationType,
        'mobileCountryCode': mobileCountryCode,
        'maxLength': maxLength,
        'accountMaxLength': accountMaxLength,
        'accountMinLength': accountMinLength,
        'exchangeRate': exchangeRate,
        'loqateIso2': loqateIso2,
      };
  String toMap() => json.encode(toJson());
  bool get isEmpty => this == CountryData.empty();

  final String countryName;
  final String countryId;
  final String flag;
  final String currencyCode;
  final String slug;
  final int applicationType;
  final String mobileCountryCode;
  final int maxLength;
  final String? loqateIso2;
  final int? accountMaxLength;
  final int? accountMinLength;
  final double exchangeRate;

  @override
  List<Object?> get props => [
        countryName,
        countryId,
        flag,
        currencyCode,
        slug,
        applicationType,
        mobileCountryCode,
        maxLength,
        accountMaxLength,
        accountMinLength,
        exchangeRate,
        loqateIso2,
      ];
}
