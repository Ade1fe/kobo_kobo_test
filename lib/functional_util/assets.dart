// base path for assets (svg and png) path
const String baseSvgPath = 'assets/svg';
const String baseGifPath = 'assets/gif';

const String basePngPath = 'assets/png';

final String profileBg = 'profile_bg'.png;

//splash screen assets
final String appSvgLogo = 'app-logo'.svg;
final String appPngLogo = 'logo'.logoPng;
final String scaffoldBgPng = 'scaffold_bg'.bgPng;
final String scaffoldTopBottomPng = 'scaffold_top_bottom'.bgPng;
final String appEdgeSvgLogo = 'app-edge-logo'.svg;
final String appScaffoldSvgLogo = 'scaffold-bg-app-logo'.svg;
final String bvnPersonPng = 'bvn-person'.onbPng;
final String pinLockPng = 'pin-lock'.onbPng;
final String lightingSvg = 'lighting'.svg;
final String lockSvg = 'lock'.svg;
final String shieldSvg = 'shield'.svg;
final String asterickSvg = 'asteric'.svg;
final String checkedSvg = 'checked'.svg;
final String circleSvg = 'circle'.svg;
final String checkedCircleSvg = 'checked-circle'.svg;
final String purpleInfoSvg = 'purple-info'.svg;
final String inflowArrowSvg = 'inflow-arrow'.svg;
final String outflowArrowSvg = 'outflow-arrow'.svg;
// biometric
final String faceIdSvg = 'faceId'.svg;

// Onboarding screen assets
final String onb1 = 'splash1'.onbPng;
final String onb2 = 'splash2'.onbPng;
final String onb3 = 'splash3'.onbPng;

// nav icons
final String homeActive = 'home'.navSvg;
final String homeInActive = 'homeI'.navSvg;
final String loansInactive = 'wallet'.navSvg;
final String loansActive = 'walletA'.navSvg;
final String cardActive = 'cardA'.navSvg;
final String cardInactive = 'card'.navSvg;
final String moreInactive = 'more'.navSvg;
final String moreActive = 'moreA'.navSvg;

final String transferPng = 'transfer'.dashboardPng;
final String billsPng = 'bills'.dashboardPng;
final String savingsPng = 'savings'.dashboardPng;
final String topUpPng = 'top-up'.dashboardPng;
// transfer
final String koboWhitePng = 'kobo-white'.dashboardPng;
final String bankPng = 'bank'.dashboardPng;
final String successSvg = 'success'.svg;
final String successPng = 'success-png'.png;
final String failedPng = 'failed-png'.png;
final String cancelSvg = 'cancel'.svg;
final String deleteSvg = 'delete'.svg;

// bills from dashboard assets
final String buyAirtime = 'airtime'.dashboardSvg;
final String buyData = 'data'.dashboardSvg;
final String cableTv = 'cable'.dashboardSvg;
final String electricity = 'electricity'.dashboardSvg;
final String internet = 'internet'.dashboardSvg;
final String sports = 'sports'.dashboardSvg;
final String dstv = 'dstv'.dashboardPng;
final String gotv = 'gotv'.dashboardPng;
final String startimes = 'startimes'.dashboardPng;
final String showmax = 'showmax'.dashboardPng;
final String aedc = 'aedc'.dashboardPng;
final String ekedc = 'ekedc'.dashboardPng;
final String ibedc = 'ibedc'.dashboardPng;
final String ikedc = 'ikedc'.dashboardPng;
final String phdc = 'phdc'.dashboardPng;

// savings from dashboard assets
final String lockSavingsPng = 'lock-savings'.savingsPng;
final String phoneBookPng = 'phone-book'.savingsPng;

// loan assets
final String loanImgOne = 'stack_of_money'.loanPng;
final String loanModaImg = 'loan_moda_img'.modaPng;
final String sadFaceImg = 'sad_face'.sadFpng;
final String emailImg = 'emailImg'.emailPng;
final String loanFingerSvg = 'finger'.svg;
final String pointerImg = 'pointer'.pointerPng;
final String easiLoanImg = 'easiLoan'.easiLoanPng;
final String addEIcon = 'addIcon'.addEIconPng;

final String cardImg = 'cardImg'.png;

// employment details
final String empProfilePic = 'profilepic'.empProfilePicPng;
final String editIconImg = 'editfill'.editPicPng;
final String atIconImg = 'atimg'.atPicPng;

// notify
final String emailSentImg = 'emailSent'.emailPicPng;
final String emailApvImg = 'emailApprove'.emailAppvPicPng;
final String emailRejImg = 'emailRej'.emailRejPicPng;
final String emaildisImg = 'emaildis'.emaildisPicPng;
final String emailerrorImg = 'loanerr'.emailErrPicPng;
final String questImg = 'quest'.questPicPng;

// more
final String noImg = '123'.noImgPng;
final String fingerImg = 'finger'.fingerPng;
final String notesImg = 'notes'.notesPng;
final String acctstImg = 'acctst'.acctstPng;
final String cameraImg = 'camera'.cameraPng;
final String camImg = 'cam'.camPng;

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///

// Recipient/Beneficiaries screen assets
final String arrowRight = 'arrow-right'.recipientSvg;
final String noBene = 'no-beneficiary'.recipientSvg;

// Help screen assets
final String facebookIcon = 'facebook'.helpSvg;
final String instagramIcon = 'instagram'.helpSvg;
final String twitterIcon = 'twitter'.helpSvg;
final String faqIcon = 'quiz'.helpSvg;
final String messageIcon = 'message'.helpSvg;
final String chatIcon = 'chat'.helpSvg;

// Country assets
String getCountryFlag(String code) {
  switch (code.toLowerCase()) {
    case 'ngn':
    case 'nigeria':
      return nigeriaSvg;
    case 'kes':
    case 'kenya':
      return kenyaSvg;
    case 'ghs':
    case 'ghana':
      return ghanaSvg;
    default:
      return ukSvg;
  }
}

final String nigeriaSvg = 'nigeria'.flagSvg;
final String canadaSvg = 'canada'.flagSvg;
final String ukSvg = 'uk_flag'.flagSvg;
final String euroSvg = 'euro'.flagSvg;
final String kenyaSvg = 'kenya'.flagSvg;
final String ghanaSvg = 'ghana'.flagSvg;
final String unitedStatesSvg = 'united-states'.flagSvg;
final String bukinafasoSvg = 'bukinafaso'.flagSvg;
final String maliSvg = 'mali'.flagSvg;
final String senegalSvg = 'senegal'.flagSvg;
final String beninSvg = 'benin-republic'.flagSvg;
final String coteSvg = 'cote-divoire'.flagSvg;
final String nigerSvg = 'niger'.flagSvg;
final String togoSvg = 'togo'.flagSvg;
final String guineaSvg = 'guinea-bissau'.flagSvg;
final String mexicoSvg = 'mexico'.flagSvg;
final String chinaSvg = 'flag-china'.flagSvg;
final String australiaSvg = 'australia_flag'.flagSvg;
final String beninRepublicSvg = 'benin_republic'.flagSvg;
final String burkinafasoSvg = 'burkinafaso'.flagSvg;
final String coteDivoireSvg = 'cote-divoire'.flagSvg;
final String indiaSvg = 'india'.flagSvg;

// dashboard kyc
final String emailVerified = 'email_verified'.dashboardSvg;
final String idCard = 'id_card'.dashboardSvg;
final String emptyTransactionSvg = 'empty_transaction'.dashboardSvg;
final String sentIconSvg = 'sent_icon'.dashboardSvg;
final String accountPng = 'account_icon'.kycPng;
final String accountActivePng = 'account_icon_active'.kycPng;
final String idCardPng = 'id_card_3d'.kycPng;
final String kycAvatarPng = 'kyc_avatar'.kycPng;
final String kycBiometryPng = 'kyc_biometry'.kycPng;
final String kycEmailPng = 'kyc_email'.kycPng;
final String kycFolderPng = 'kyc_folder'.kycPng;
final String kycIdPng = 'kyc_id'.kycPng;
final String kycStepDOnePng = 'kyc_step_done'.kycPng;
final String kycSuccessPng = 'kyc_success'.kycPng;
final String kycUploadPlaceHolderPng = 'kyc_upload_placeholder'.kycPng;
final String kycUserPng = 'kyc_user'.kycPng;

final String amlRequired = 'aml_required'.kycSvg;
final String kycFailed = 'kyc_failed'.kycSvg;
final String kycPending = 'kyc_pending'.kycSvg;
final String kycPendingPng = 'hourglass_3d'.kycPng;
final String kycStepDone = 'kyc_step_done'.kycSvg;
final String kycStep = 'kyc_step'.kycSvg;
final String kycHourGlass = 'hourglass-pending'.kycSvg;

// transactions
final String checkedIconSvg = 'checked'.transactionsSvg;
final String menuIconSvg = 'menu'.transactionsSvg;
final String transactionDetailBg = 'transaction_details_bg'.transactionsPng;
final String transactionSumFailed =
    'transaction_summary_failed'.transactionsPng;
final String transactionSumSuccess =
    'transaction_summary_success'.transactionsPng;
final String transactionSumPending =
    'transaction_summary_pending'.transactionsPng;
//transaction (ca/ngn)
final String pendingIcon = 'pending'.transactionsSvg;
final String successIcon = 'transaction_successful'.transactionsSvg;
final String failedIcon = 'transaction_failed'.svg;
final String deleteFileIcon = 'delete-file'.png;
final String noTransaction = 'no_transaction'.svg;
final String notificationBellSvg = 'notification_bell'.svg;
final String verificationIcon = 'verirication_complete_icon'.svg;
final String fingerPrint = 'fingerprint'.png;
final String referralCard = 'referral_card_bg'.png;
final String dashboardBg = 'dashboard_background_1'.png;
final String fingerprint = 'fingerprint'.png;

// send
final String closeSquareSvg = 'close-square'.sendMoneySvg;
final String minusSvg = 'minus-square'.sendMoneySvg;
final String equalSvg = 'document'.sendMoneySvg;
final String singleUserSvg = 'single-user'.sendMoneySvg;
final String doubleUserSvg = 'double-user'.sendMoneySvg;
final String emptyContactListSvg = 'empty-contacts'.sendMoneySvg;
final String chartSvg = 'chart'.sendMoneySvg;
final String transferLimitSvg = 'transfer-limit'.sendMoneySvg;
final String greenCheckedSvg = 'green-checked'.sendMoneySvg;
final String closedX = 'close-x'.sendMoneySvg;
final String fraud = 'fraud-lock'.sendMoneySvg;
final String fraudPointer = 'fraud-pointer'.sendMoneySvg;
//send make payment
final String awaitTimer = 'make-payment-await-timer'.sendMoneySvg;
final String cancel = 'make-payment-cancel'.sendMoneySvg;
final String greenChecker = 'make-payment-green-check'.sendMoneySvg;
final String info = 'make-payment-info'.sendMoneySvg;
final String timer = 'make-payment-timer'.sendMoneySvg;
final String sendBg = 'make-payment-sendBg'.sendPng;
final String bankSendSvg = 'send_bank'.sendMoneySvg;
final String payToSendPng = 'send_payTo'.sendPng;
// send money screen
final String checkRates = 'check_rates'.sendMoneySvg;
final String downloadStatement = 'download_statement'.sendMoneySvg;
final String sendMoney = 'send_money'.sendMoneySvg;
final String instantBank = 'instant_bank'.sendMoneySvg;
final String regularBank = 'regular_bank'.sendMoneySvg;
final String peerSvg = 'double-user'.sendMoneySvg;
final String statementDownloadPng = 'statement_download_success'.sendPng;
final String emptySearchUserPng = 'search-not-found'.sendPng;
final String exchangeRateWarningPng = 'warning_round'.sendPng;
final String thinSearchSvg = 'thin_search'.sendMoneySvg;
final String paymentSuccessSvg = 'payment_success'.sendMoneySvg;

//wallet
final String debitTransaction = 'transaction_out'.walletSvg;
final String cautionSvg = 'caution_angle'.walletSvg;
final String creditTransaction = 'transaction_in'.walletSvg;
final String walletCardPatternedBg = 'wallet_balance_bg'.png;
final String wallet = 'wallet'.walletPng;
final String walletBalanceBg = 'wallet_balance_bg'.walletPng;
final String alertBellPng = 'alert_bell'.walletPng;

// referral screen
final String refBag = 'ref-bag'.referralSvg;
final String whatsApp = 'whats-app'.referralSvg;
final String facebook = 'facebook'.referralSvg;
final String twitter = 'twitter'.referralSvg;
final String email = 'email'.referralSvg;
final String refBg = 'referralBg'.referralSvg;

//security
final String appStore = 'appstore_icon'.png;
final String playStore = 'playstore_icon'.png;
final String googleAuth = 'google_authenticator_icon'.png;
final String transactionPinPrompt = 'pin_prompt'.png;
final String deleteAccount = 'delete_thrash'.svg;

//user tier
String tierImage(int tier) => 'tier_$tier'.tierPng;
final String cloudImage = 'cloud_upload'.profileSvg;
final String cameraRound = 'camera_round'.profileSvg;
final String cloudLargeImage = 'cloud_upload_large'.profileSvg;
// profile
final String deactivateImage = 'deactivate_icon'.profileSvg;
final String infoLetter = 'info_letter'.profilePng;
final String deleteIcon = 'delete'.profileSvg;
final String resetPasswordIcon = 'reset_password'.profileSvg;
final String transactionPinIcon = 'transaction_pin'.profileSvg;
final String twoFaIcon = 'new_2fa'.profileSvg;
final String numberPadBackSpace = 'backspace'.profileSvg;

//rewards
final String rewardMonthly = 'reward_monthly_streak'.png;
final String rewardOnboarding = 'reward_onboarding'.png;
final String rewardTransaction = 'reward_transaction'.png;
final String rewardSvg = 'reward'.rewardSvg;

// gif files
final emailGif = 'email_kyc'.gif;
final paymentSuccessGif = 'payment_success'.gif;

// extensions
extension ImageExtension on String {
  // get png paths
  String get png => '$basePngPath/$this.png';
  String get logoPng => '$basePngPath/logo/$this.png';
  String get bgPng => '$basePngPath/bg/$this.png';
  // get svgs path
  String get svg => '$baseSvgPath/$this.svg';
  // get gif path
  String get gif => '$baseGifPath/$this.gif';
  // get splash path
  String get splashSvg => '$baseSvgPath/splash/$this.svg';

  // onboard assets
  String get onbPng => '$basePngPath/onboarding/$this.png';
  String get kycPng => '$basePngPath/kyc/$this.png';
  String get kycSvg => '$baseSvgPath/kyc/$this.svg';

  //get country svg path
  String get flagSvg => '$baseSvgPath/flag/$this.svg';
  // get nav assets
  String get navSvg => '$baseSvgPath/nav/$this.svg';

  // get dashboard assets
  String get dashboardSvg => '$baseSvgPath/dashboard/$this.svg';
  String get dashboardPng => '$basePngPath/dash/$this.png';
  String get savingsPng => '$basePngPath/savings/$this.png';

  // get dashboard assets
  String get transactionsSvg => '$baseSvgPath/transactions/$this.svg';
  // onboard assets
  String get transactionsPng => '$basePngPath/transactions/$this.png';
  // get recipient assets
  String get recipientSvg => '$baseSvgPath/recipient/$this.svg';

  // get recipient assets
  String get helpSvg => '$baseSvgPath/help/$this.svg';

  //get send money assets
  String get sendMoneySvg => '$baseSvgPath/send/$this.svg';
  // send png assets
  String get sendPng => '$basePngPath/send/$this.png';
  // wallet png assets
  String get walletPng => '$basePngPath/wallet/$this.png';
  //get wallet assets
  String get walletSvg => '$baseSvgPath/wallet/$this.svg';
  //get notifications assets
  String get notificationsSvg => '$baseSvgPath/notifications/$this.svg';

  //get referral assets
  String get referralSvg => '$baseSvgPath/referral/$this.svg';

  // get profile assets
  String get profileSvg => '$baseSvgPath/profile/$this.svg';
  String get profilePng => '$basePngPath/profile/$this.png';
  String get tierPng => '$basePngPath/tier/$this.png';

  // rewards
  String get rewardSvg => '$baseSvgPath/rewards/$this.svg';

  // get biometric assets
  String get biometricSvg => '$baseSvgPath/biometric/$this.svg';

  // get loan assets
  String get loanSvg => '$baseSvgPath/loans/$this.svg';
  String get loanPng => '$basePngPath/loans/$this.png';
  String get modaPng => '$basePngPath/loans/$this.png';
  String get sadFpng => '$basePngPath/loans/$this.png';
  String get emailPng => '$basePngPath/loans/$this.png';
  String get pointerPng => '$basePngPath/loans/$this.png';
  String get easiLoanPng => '$basePngPath/loans/$this.png';
  String get addEIconPng => '$basePngPath/loans/$this.png';

  // get employment details
  String get empProfilePicPng => '$basePngPath/emp_detail/$this.png';
  String get editPicPng => '$basePngPath/emp_detail/$this.png';
  String get atPicPng => '$basePngPath/emp_detail/$this.png';

  // get notify
  String get emailPicPng => '$basePngPath/notify/$this.png';
  String get emailAppvPicPng => '$basePngPath/notify/$this.png';
  String get emailRejPicPng => '$basePngPath/notify/$this.png';
  String get emaildisPicPng => '$basePngPath/notify/$this.png';
  String get emailErrPicPng => '$basePngPath/notify/$this.png';
  String get questPicPng => '$basePngPath/notify/$this.png';

// get more
  String get noImgPng => '$basePngPath/more/$this.png';
  String get fingerPng => '$basePngPath/more/$this.png';
  String get notesPng => '$basePngPath/more/$this.png';
  String get acctstPng => '$basePngPath/more/$this.png';
  String get cameraPng => '$basePngPath/more/$this.png';
  String get camPng => '$basePngPath/more/$this.png';
}
