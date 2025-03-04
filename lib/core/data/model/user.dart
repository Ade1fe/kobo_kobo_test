// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:kobo_kobo/core/data/core_data.dart';
import 'package:equatable/equatable.dart';

class AppUserData extends Equatable {
  const AppUserData({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.referralCode,
    required this.profilePictureUrl,
    required this.address,
    required this.isDeactivated,
    required this.isPinEnabled,
    required this.pin,
    required this.dateDeactivated,
    required this.deactivationReason,
    required this.userType,
    required this.isKycVerified,
    required this.verficationId,
    required this.kycResponseString,
    required this.userHandle,
    required this.appType,
    required this.city,
    required this.occupation,
    required this.residenceCountry,
    required this.verificationStage,
    required this.firstProfileUpdateCompleted,
    required this.promoCode,
    required this.interactEmail,
    required this.secretQuestion,
    required this.secretAnswer,
    required this.applicationType,
    required this.socialSecurityNumber,
    required this.userPrivateKey,
    required this.kycStatus,
    required this.kycReferenceId,
    required this.kycTrials,
    required this.state,
    required this.postalCode,
    required this.walletAddress,
    required this.id,
    required this.bvn,
    required this.userName,
    required this.email,
    required this.emailConfirmed,
    required this.phoneNumber,
    required this.phoneNumberConfirmed,
    required this.twoFactorEnabled,
    required this.hasCompletedOnboardingQuestions,
    required this.isOnboardingPointEligible,
    required this.countryData,
    required this.isUserDeactivated,
    required this.deactivatedBy,
    required this.isThirdPartyDepositEnable,
    required this.isUserSecurityQuestionsSet,
    required this.userSkipCount,
  });

  factory AppUserData.fromJson(String source) =>
      AppUserData.fromMap(json.decode(source));

  factory AppUserData.fromMap(Map<String, dynamic> json) {
    if (json.isEmpty) return AppUserData.empty();

    return AppUserData(
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      referralCode: json['referralCode'] ?? '',
      profilePictureUrl: json['profilePictureUrl'] ?? '',
      address: json['address'] ?? '',
      isDeactivated: json['isDeactivated'] ?? false,
      isPinEnabled: json['isPinEnabled'] ?? false,
      hasCompletedOnboardingQuestions:
          json['hasCompletedOnboardingQuestions'] ?? false,
      pin: json['pin']?.toString() ?? '',
      dateDeactivated: json['dateDeactivated'] ?? '',
      deactivationReason: json['deactivationReason'] ?? '',
      isKycVerified: json['isKYCVerified'] ?? false,
      verficationId: json['verficationId'] ?? '',
      kycResponseString: json['kycResponseString'] ?? '',
      userHandle: json['userHandle'] ?? '',
      appType: json['appType']?.toString() ?? '',
      city: json['city'] ?? '',
      occupation: json['occupation'] ?? '',
      residenceCountry: json['residenceCountry'] ?? '',
      bvn: json['bvn'] ?? '',
      firstProfileUpdateCompleted: json['firstProfileUpdateCompleted'] ?? false,
      promoCode: json['promoCode'] ?? '',
      interactEmail: json['interactEmail'] ?? '',
      secretQuestion: json['secretQuestion'] ?? '',
      secretAnswer: json['secretAnswer'] ?? '',
      socialSecurityNumber: json['socialSecurityNumber'] ?? '',
      isThirdPartyDepositEnable: json['isThirdPartyDepositEnable'] ?? false,
      userPrivateKey: json['userPrivateKey'] ?? '',
      kycReferenceId: json['kycReferenceId'] ?? '',
      kycTrials: json['kycTrials'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      walletAddress: json['walletAddress'] ?? '',
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      emailConfirmed: json['emailConfirmed'] ?? false,
      phoneNumber: json['phoneNumber'] ?? '',
      phoneNumberConfirmed: json['phoneNumberConfirmed'] ?? false,
      twoFactorEnabled: json['twoFactorEnabled'] ?? false,
      verificationStage: json['verificationStage'] ?? 0,
      gender: json['gender'] == null
          ? Gender.male
          : Gender.values.firstWhere(
              (e) => e.value == json['gender'],
              orElse: () => Gender.male,
            ),
      userType: json['userType'] ?? 0,
      kycStatus: json['kycStatus'] ?? 0,
      isOnboardingPointEligible: json['isOnboardingPointEligible'] ?? false,
      // data type that are not sure but works with this
      applicationType: json['applicationType']?.toString() ?? '',
      countryData: json['countryData'] != null
          ? CountryData.fromJson(json['countryData'])
          : CountryData.empty(),
      isUserDeactivated: json['isUserDeactivated'] ?? false,
      deactivatedBy: json['deactivatedBy'] ?? '',
      isUserSecurityQuestionsSet: json['isUserSecurityQuestionsSet'] ?? '',
      userSkipCount: json['userSkipCount'] ?? 0,
    );
  }

  factory AppUserData.empty() => AppUserData(
        kycStatus: 0,
        verificationStage: 0,
        firstName: '',
        middleName: '',
        lastName: '',
        dateOfBirth: '',
        referralCode: '',
        isDeactivated: false,
        isPinEnabled: false,
        dateDeactivated: '',
        isKycVerified: false,
        firstProfileUpdateCompleted: false,
        secretQuestion: '',
        secretAnswer: '',
        bvn: '',
        phoneNumber: '',
        hasCompletedOnboardingQuestions: false,
        isThirdPartyDepositEnable: false,
        socialSecurityNumber: '',
        userPrivateKey: '',
        userHandle: '',
        appType: '',
        city: '',
        occupation: '',
        residenceCountry: '',
        promoCode: '',
        interactEmail: '',
        applicationType: '',
        kycReferenceId: '',
        kycTrials: '',
        state: '',
        postalCode: '',
        walletAddress: '',
        gender: Gender.male, // => 0
        profilePictureUrl: '',
        address: '',
        pin: '',
        deactivationReason: '',
        userType: 0,
        verficationId: '',
        kycResponseString: '',
        id: '',
        userName: '',
        email: '',
        emailConfirmed: false,
        phoneNumberConfirmed: false,
        twoFactorEnabled: false,
        isOnboardingPointEligible: false,
        countryData: CountryData.empty(),
        isUserDeactivated: false,
        deactivatedBy: '',
        isUserSecurityQuestionsSet: false,
        userSkipCount: 0,
      );

  final String firstName;
  final String middleName;
  final String lastName;
  final String dateOfBirth;
  final Gender gender;
  final String referralCode;
  final String profilePictureUrl;
  final String address;
  final bool isDeactivated;
  final bool isPinEnabled;
  final String pin;
  final String dateDeactivated;
  final String deactivationReason;
  final int userType;
  final bool isKycVerified;
  final String verficationId;
  final String kycResponseString;
  final String userHandle;
  final String appType;
  final String city;
  final String occupation;
  final String residenceCountry;
  final int verificationStage;
  final bool firstProfileUpdateCompleted;
  final String promoCode;
  final String interactEmail;
  final bool isThirdPartyDepositEnable;
  final String secretQuestion;
  final String secretAnswer;
  final String applicationType;
  final String socialSecurityNumber;
  final String userPrivateKey;
  final int kycStatus;
  final String kycReferenceId;
  final String kycTrials;
  final String state;
  final String postalCode;
  final String walletAddress;
  final String id;
  final String userName;
  final String bvn;
  final String email;
  final bool emailConfirmed;
  final String phoneNumber;
  final bool phoneNumberConfirmed;
  final bool twoFactorEnabled;
  final bool hasCompletedOnboardingQuestions;
  final bool isOnboardingPointEligible;
  final CountryData countryData;
  final bool isUserDeactivated;
  final String deactivatedBy;
  final bool isUserSecurityQuestionsSet;
  final int userSkipCount;

//NOTE: this validates first profile completion data
  bool get getFirstProfileComplete => firstProfileUpdateCompleted;

//NOTE: this validates first profile completion data and KYC validation (true is to say that user has completed kyc and first profile)
  bool get getAbsoluteVerification =>
      isKycVerified && getFirstProfileComplete && emailConfirmed;

//NOTE: this validates if user has done questionnaire
  bool get getQuestionnaireStatus => hasCompletedOnboardingQuestions;

  String get fullName => '$firstName $lastName';

  bool get userIsNigerian =>
      residenceCountry.toLowerCase() == 'ng' ||
      residenceCountry.toLowerCase() == 'ngn' ||
      residenceCountry.toLowerCase() == 'nigeria';

  bool get userIsAustralian =>
      residenceCountry.toLowerCase() == 'aus' ||
      residenceCountry.toLowerCase() == 'au' ||
      residenceCountry.toLowerCase() == 'australia';

  bool get userIsBritish =>
      residenceCountry.toLowerCase().contains('gbp') ||
      residenceCountry.toLowerCase().contains('gb') ||
      residenceCountry.toLowerCase().contains('united');

  bool get userIsCanadian =>
      residenceCountry.toLowerCase() == 'cad' ||
      residenceCountry.toLowerCase() == 'ca' ||
      residenceCountry.toLowerCase() == 'canada';

  // Checks if the user deactivated their account themselves via the app.
  bool get isUserThatDeactivatedAccount => email == deactivatedBy;

  bool get isEmpty => this == AppUserData.empty();

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'gender': gender.value,
      'referralCode': referralCode,
      'profilePictureUrl': profilePictureUrl,
      'address': address,
      'isDeactivated': isDeactivated,
      'isPinEnabled': isPinEnabled,
      'pin': pin,
      'dateDeactivated': dateDeactivated,
      'deactivationReason': deactivationReason,
      'userType': userType,
      'isKYCVerified': isKycVerified,
      'verficationId': verficationId,
      'kycResponseString': kycResponseString,
      'bvn': bvn,
      'userHandle': userHandle,
      'appType': appType,
      'city': city,
      'occupation': occupation,
      'residenceCountry': residenceCountry,
      'isThirdPartyDepositEnable': isThirdPartyDepositEnable,
      'verificationStage': verificationStage,
      'firstProfileUpdateCompleted': firstProfileUpdateCompleted,
      'promoCode': promoCode,
      'interactEmail': interactEmail,
      'secretQuestion': secretQuestion,
      'secretAnswer': secretAnswer,
      'applicationType': applicationType,
      'socialSecurityNumber': socialSecurityNumber,
      'userPrivateKey': userPrivateKey,
      'kycStatus': kycStatus,
      'kycReferenceId': kycReferenceId,
      'kycTrials': kycTrials,
      'state': state,
      'postalCode': postalCode,
      'walletAddress': walletAddress,
      'id': id,
      'userName': userName,
      'email': email,
      'emailConfirmed': emailConfirmed,
      'phoneNumber': phoneNumber,
      'phoneNumberConfirmed': phoneNumberConfirmed,
      'twoFactorEnabled': twoFactorEnabled,
      'hasCompletedOnboardingQuestions': hasCompletedOnboardingQuestions,
      'isOnboardingPointEligible': isOnboardingPointEligible,
      'countryData': countryData.toMap(),
      'isUserDeactivated': isUserDeactivated,
      'deactivatedBy': deactivatedBy,
      'isUserSecurityQuestionsSet': isUserSecurityQuestionsSet,
      'userSkipCount': userSkipCount,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      firstName,
      lastName,
      dateOfBirth,
      referralCode,
      isDeactivated,
      isPinEnabled,
      dateDeactivated,
      isKycVerified,
      firstProfileUpdateCompleted,
      secretQuestion,
      secretAnswer,
      bvn,
      phoneNumber,
      hasCompletedOnboardingQuestions,
      socialSecurityNumber,
      userPrivateKey,
      userHandle,
      appType,
      city,
      occupation,
      residenceCountry,
      verificationStage,
      promoCode,
      interactEmail,
      applicationType,
      kycStatus,
      kycReferenceId,
      kycTrials,
      state,
      postalCode,
      walletAddress,
      gender,
      profilePictureUrl,
      isThirdPartyDepositEnable,
      address,
      pin,
      deactivationReason,
      userType,
      verficationId,
      kycResponseString,
      id,
      userName,
      email,
      emailConfirmed,
      phoneNumberConfirmed,
      twoFactorEnabled,
      isOnboardingPointEligible,
      countryData,
      isUserDeactivated,
      deactivatedBy,
      isUserSecurityQuestionsSet,
      userSkipCount,
    ];
  }

  AppUserData copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? dateOfBirth,
    Gender? gender,
    String? referralCode,
    String? profilePictureUrl,
    String? address,
    bool? isDeactivated,
    bool? isPinEnabled,
    String? pin,
    String? dateDeactivated,
    String? deactivationReason,
    int? userType,
    bool? isKycVerified,
    String? verficationId,
    String? kycResponseString,
    String? userHandle,
    String? appType,
    String? city,
    String? occupation,
    String? residenceCountry,
    int? verificationStage,
    bool? firstProfileUpdateCompleted,
    String? promoCode,
    String? interactEmail,
    String? secretQuestion,
    String? secretAnswer,
    String? applicationType,
    String? socialSecurityNumber,
    String? userPrivateKey,
    int? kycStatus,
    String? kycReferenceId,
    String? kycTrials,
    String? state,
    String? postalCode,
    String? walletAddress,
    String? id,
    String? userName,
    String? bvn,
    String? email,
    bool? emailConfirmed,
    String? phoneNumber,
    bool? phoneNumberConfirmed,
    bool? twoFactorEnabled,
    bool? hasCompletedOnboardingQuestions,
    bool? isOnboardingPointEligible,
    CountryData? countryData,
    bool? isUserDeactivated,
    bool? isThirdPartyDepositEnable,
    String? deactivatedBy,
    bool? isUserSecurityQuestionsSet,
    int? userSkipCount,
  }) {
    return AppUserData(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      referralCode: referralCode ?? this.referralCode,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      address: address ?? this.address,
      isDeactivated: isDeactivated ?? this.isDeactivated,
      isPinEnabled: isPinEnabled ?? this.isPinEnabled,
      pin: pin ?? this.pin,
      dateDeactivated: dateDeactivated ?? this.dateDeactivated,
      deactivationReason: deactivationReason ?? this.deactivationReason,
      userType: userType ?? this.userType,
      isKycVerified: isKycVerified ?? this.isKycVerified,
      verficationId: verficationId ?? this.verficationId,
      kycResponseString: kycResponseString ?? this.kycResponseString,
      userHandle: userHandle ?? this.userHandle,
      appType: appType ?? this.appType,
      city: city ?? this.city,
      occupation: occupation ?? this.occupation,
      residenceCountry: residenceCountry ?? this.residenceCountry,
      verificationStage: verificationStage ?? this.verificationStage,
      firstProfileUpdateCompleted:
          firstProfileUpdateCompleted ?? this.firstProfileUpdateCompleted,
      promoCode: promoCode ?? this.promoCode,
      interactEmail: interactEmail ?? this.interactEmail,
      secretQuestion: secretQuestion ?? this.secretQuestion,
      secretAnswer: secretAnswer ?? this.secretAnswer,
      applicationType: applicationType ?? this.applicationType,
      socialSecurityNumber: socialSecurityNumber ?? this.socialSecurityNumber,
      userPrivateKey: userPrivateKey ?? this.userPrivateKey,
      kycStatus: kycStatus ?? this.kycStatus,
      kycReferenceId: kycReferenceId ?? this.kycReferenceId,
      kycTrials: kycTrials ?? this.kycTrials,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      walletAddress: walletAddress ?? this.walletAddress,
      id: id ?? this.id,
      userName: userName ?? this.userName,
      bvn: bvn ?? this.bvn,
      email: email ?? this.email,
      emailConfirmed: emailConfirmed ?? this.emailConfirmed,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberConfirmed: phoneNumberConfirmed ?? this.phoneNumberConfirmed,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      hasCompletedOnboardingQuestions: hasCompletedOnboardingQuestions ??
          this.hasCompletedOnboardingQuestions,
      isOnboardingPointEligible:
          isOnboardingPointEligible ?? this.isOnboardingPointEligible,
      countryData: countryData ?? this.countryData,
      isUserDeactivated: isUserDeactivated ?? this.isUserDeactivated,
      deactivatedBy: deactivatedBy ?? this.deactivatedBy,
      isThirdPartyDepositEnable:
          isThirdPartyDepositEnable ?? this.isThirdPartyDepositEnable,
      isUserSecurityQuestionsSet:
          isUserSecurityQuestionsSet ?? this.isUserSecurityQuestionsSet,
      userSkipCount: userSkipCount ?? this.userSkipCount,
    );
  }
}
