import 'package:equatable/equatable.dart';

// For "/Auth/phone-otp" endpoint the fields that should be passed are
// - phoneNumber
// - countryDialCode
// - email
//
// For "/User/V2/RequestVerificationOTP" endpoint the fields that should be
// passed are
// - phoneNumber
// - countryCode
// - userId
class SendOtpRequest extends Equatable {
  const SendOtpRequest({
    required this.phoneNumber,
    this.countryDialCode,
    this.countryCode,
    this.email,
    this.userId,
  });

  factory SendOtpRequest.empty() => const SendOtpRequest(
        countryDialCode: '',
        countryCode: '',
        email: '',
        phoneNumber: '',
        userId: '',
      );

  SendOtpRequest copyWith({
    String? phoneNumber,
    String? countryDialCode,
    String? countryCode,
    String? email,
    String? userId,
  }) {
    assert(
      countryDialCode == null || countryCode == null,
      "Provide only one of 'countryDialCode' or 'countryCode', not both.",
    );
    assert(
      email == null || userId == null,
      "Provide only one of 'email' or 'userId', not both.",
    );
    return SendOtpRequest(
      countryDialCode: countryDialCode ?? this.countryDialCode,
      countryCode: countryCode ?? this.countryCode,
      email: email ?? this.email,
      userId: userId ?? this.userId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  final String phoneNumber;
  final String? countryDialCode;
  final String? countryCode;
  final String? email;
  final String? userId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    if (countryDialCode?.isNotEmpty == true) {
      data['countryDialCode'] = countryDialCode;
    }
    if (email?.isNotEmpty == true) {
      data['email'] = email;
    }
    if (countryCode?.isNotEmpty == true) {
      data['countryCode'] = countryCode;
    }
    if (userId?.isNotEmpty == true) {
      data['userId'] = userId;
    }
    return data;
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        countryDialCode,
        email,
        countryCode,
        userId,
      ];
}
