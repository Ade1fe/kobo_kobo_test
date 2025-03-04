import 'package:flutter/material.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

const kFontFamily = 'Gilroy';
const kAnimationDuration = Duration(milliseconds: 200);
const String kLanguage = 'en';
const String kRegionLocation = 'CA';
const String kAppName = 'APP_NAME';
const String kDevApiBaseURl = 'APP_DEV_URL';
const String kStagingApiBaseURl = 'APP_STAGING_URL';
const String kPreProdApiBaseURl = 'APP_PREPROD_URL';
const String kProdApiBaseURl = 'APP_PROD_URL';
const String kPurposeOfPayment = 'payment_purpose';
const String kDeactivatedReason = 'account_de_reasons';

class CacheKeys {
  static const user = 'user';
  static const authData = 'auth_data';
  static const token = 'accessToken';
  static const amlStatus = 'aml_status';
  static const pinEnabled = 'pin_enabled';
  static const twoFaEnabled = 'two_fa_enabled';
  static const securityQuestionSet = 'security_question_set';
  static const amlQuestionnaireStatus = 'aml_questionnaire_status';
  static const email = 'user_email';
  static const password = 'user_password';
  static const phoneNumber = 'user_phone_number';
  static const biometric = 'biometric';
  static const biometricMode = 'biometric_mode';
  static const showVerificationBanner = 'show_verification_banner';
  static const contacts = 'contacts';
}

class AppColors {
  static const textHeaderColor = Color(0xFF333D47);
  static const textBodyColor = Color(0xFF6C7884);

  static const scaffold = Color(0xFFFFFFFF);
  static const appPrimaryColor = Color(0xFFFF7517);
  static const appSecondaryColor = Color(0xFF056455);
  static const backButtonColor = Color(0xFFABB0BA);
  static const inactiveColor = Color(0xFFD2D5DA);
  static const green = Color(0xFF1DA62A);
  static const appPrimaryButton = appPrimaryColor;
  static const purpleColor = Color(0xff5638b0);
// bills colors
  static const airtimeColor = Color(0xFF0F31A8);
  static const dataColor = Color(0xFFFCA702);
  static const cableColor = Color(0xFF0BA81D);
  static const electricityColor = Color(0xFFEC1C24);
  static const internetColor = Color(0xFF0086FF);
  static const sportsColor = Color(0xFF877AFB);

  static const dstvColor = Color(0xFF1E78B2);
  static const gotvColor = Color(0xFF1F9853);
  static const startimes = Color(0xFFFD8C39);
  static const electricityColor1 = Color(0xFF050D71);
  static const electricityColor2 = Color(0xFF302272);
  static const electricityColor3 = Color(0xFF0E3D62);
  static Color electricityColor4 = const Color(0xFFB10E1E).withOpacity(0.5);
  static const electricityColor5 = Color(0xFF3693D0);
  static const canceledColor = Color(0xFFC31C24);

  /// !SECTION
  /// 
  /// 
  /// 
  /// 
  static const outgoingColor = Color(0xFFC33C3C);
  static const incomingColor = Color(0xFF0BA81D);

  static const litePrimaryColor = Color(0xFFF1F0FA);
  static const btnSecondaryColor = Color(0xff9EA6BE);
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const borderErrorColor = Color(0xFFDC3030);
  static Color borderColor = const Color(0xFFD9D9D9);
  static Color borderColorSplit = const Color(0xFFF0F0F0);

  static const grey = Color(0xFF676D7E);
  static Color lighterGrey = const Color(0xFFF5F5F5);
  // dashboard rates cards
  static const ratesCard = Color(0xFFECF8EF);
  static const transLimit = Color(0xFFFFF4EE);
  static const darkBrown = Color(0xFFA1619E);
  // dashboard kyc data colors for failed
  static const lighterRed = Color(0xFFFFA39E);
  static const lightestRed = Color(0xFFFFF1F0);
  static const red = Color(0xFFFFCCC7);
  static const darkRed = Color(0xFF820014);
  static const deeperRed = Color(0xFFF5222D);
  // dashboard slider
  static const slider2 = Color(0xFFFAF2E5);
  static const slider3 = Color(0xFFFCF4FA);
  // transaction status
  static const pending = Color(0xFF874D00);
  static const pendingBd = Color(0xFFFFE58F);
  static const pendingBg = Color(0xFFFFFBE6);
  static const pendingButton = Color(0xFFFFF1B8);

  // send money
  static const sendMoneyTimeBgOut = Color(0xFFE6F4FF);
  static const sendMoneyTimeOutText = Color(0xFF0958D9);
  static const optionBg = Color(0xFFF0F0F0);
  static const warning = Color(0xFFFAAD14);
  static const makePaymentBg = Color(0xFFE7E5FA);

  // referral
  static const referralDeepBg = Color(0xFF180F84);
  static const referralBg = Color(0xFFA9A9A9);

  // rates bg color
  static const ratesBg = Color(0xFFEFEBFB);

  // notifications color
  static const beneColor = Color(0xFFF1EAC6);
}

class Corners {
  static const Radius rsRadius = Radius.circular(Insets.dim_4); //really small
  static const BorderRadius rsBorder =
      BorderRadius.all(rsRadius); //really small

  static const Radius xsRadius = Radius.circular(Insets.dim_8);
  static const BorderRadius xsBorder = BorderRadius.all(xsRadius);

  static const Radius smRadius = Radius.circular(Insets.dim_12);
  static const BorderRadius smBorder = BorderRadius.all(smRadius);

  static const Radius mdRadius = Radius.circular(Insets.dim_16);
  static const BorderRadius mdBorder = BorderRadius.all(mdRadius);

  static const Radius lgRadius = Radius.circular(Insets.dim_32);
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);

  static const Radius xlRadius = Radius.circular(50);
  static const BorderRadius xlBorder = BorderRadius.all(xlRadius);
}

class XBox extends StatelessWidget {
  const XBox(this._width, {super.key});

  final double _width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
    );
  }
}

class YBox extends StatelessWidget {
  const YBox(this._height, {super.key});

  final double _height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
    );
  }
}
