import 'dart:convert';

import 'package:equatable/equatable.dart';

class SavingsDto extends Equatable {
  final num amountInvested;
  final String tenure;
  final String title;
  final num interestRate;
  final num interestEarned;
  final String investmentDate;
  final String status;
  final String maturityDate;
  final String rollover;
  final String lock;
  final num totalAmount;
  final String withdrawalType;

  const SavingsDto({
    required this.amountInvested,
    required this.tenure,
    required this.title,
    required this.interestRate,
    required this.interestEarned,
    required this.investmentDate,
    required this.status,
    required this.maturityDate,
    required this.rollover,
    required this.lock,
    required this.totalAmount,
    required this.withdrawalType,
  });

  factory SavingsDto.empty() {
    return const SavingsDto(
      amountInvested: 0,
      tenure: '',
      title: '',
      interestRate: 0,
      interestEarned: 0,
      investmentDate: '',
      status: '',
      maturityDate: '',
      rollover: '',
      lock: '',
      totalAmount: 0,
      withdrawalType: '',
    );
  }

  @override
  List<Object> get props => [
        amountInvested,
        tenure,
        title,
        interestRate,
        interestEarned,
        investmentDate,
        status,
        maturityDate,
        rollover,
        lock,
        totalAmount,
        withdrawalType,
      ];

  SavingsDto copyWith({
    num? amountInvested,
    String? tenure,
    String? title,
    num? interestRate,
    num? interestEarned,
    String? investmentDate,
    String? status,
    String? maturityDate,
    String? rollover,
    String? lock,
    num? totalAmount,
    String? withdrawalType,
  }) {
    return SavingsDto(
      amountInvested: amountInvested ?? this.amountInvested,
      tenure: tenure ?? this.tenure,
      title: title ?? this.title,
      interestRate: interestRate ?? this.interestRate,
      interestEarned: interestEarned ?? this.interestEarned,
      investmentDate: investmentDate ?? this.investmentDate,
      status: status ?? this.status,
      maturityDate: maturityDate ?? this.maturityDate,
      rollover: rollover ?? this.rollover,
      lock: lock ?? this.lock,
      totalAmount: totalAmount ?? this.totalAmount,
      withdrawalType: withdrawalType ?? this.withdrawalType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amountInvested': amountInvested,
      'tenure': tenure,
      'title': title,
      'interestRate': interestRate,
      'interestEarned': interestEarned,
      'investmentDate': investmentDate,
      'status': status,
      'maturityDate': maturityDate,
      'rollover': rollover,
      'lock': lock,
      'totalAmount': totalAmount,
      'withdrawalType': withdrawalType,
    };
  }

  String toJson() => json.encode(toMap());
}
