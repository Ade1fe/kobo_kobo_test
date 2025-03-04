// auth endpoints
class _AuthEndpoints {
  final login = '/Auth/login';
  final signUp = '/Auth/registerV2/login';

  String resendVerificationEmail(String email) =>
      '/Auth/resendConfirmationEmail?email=$email';

  final getPhoneOtp = '/Auth/phone-otp';

  final forgotPassword = '/Auth/forgotpassword';
}

class _DocumentEndpoints {
  final getIdTypeLists = '/Documents/identityTypes';
}

// user endpoints
class _UserEndpoints {
  final getUser = '/User';
  final getVerificationProgress = '/User/verificationprogress';

  final verifyUsername = '/User/verifyusername';

  final uploadProfilePicture = '/User/v2/profile/picture';

  final updateUserName = '/User/username';

  final requestOnfidoToken = '/User/SdkToken';

  final requestOnfidoCheck = '/User/onfidoCheck';

  final submitIdInfo = '/User/identityDetails';

  final userProfileUpdate = '/User/profile/update';

  final deleteAccount = '/User/delete-account';

  final deactivateAccount = '/User/deactivate-account';

  final reactivateAccount = '/User/reactivate-account';

  final verifyUserAiPrise = '/User/aipriseUserVerify';
}

class _TransactionEndpoints {
  final getTransactionHistory = '/v3/user/transactions?WalletTransactionType=0';
  final postNoDebitTransaction = '/Transactions/without-debit';
  String getTransaction(int tID) => '/Transactions/without-debit/$tID';
  String transactionFee(String s, String r) =>
      '/Transactions/transactionFee?sendCurrency=$s&receiveCurrency=$r';
  final getTransactionLimit = '/Transactions/p2p-limits';
  final sendPeerToPeer = '/Transactions/do-p2p-transfer';
  String downloadTransactionReceipt(int transactionId) =>
      '/Transactions/Transactionreceipt/$transactionId';
}

class _RateEndpoints {
  final getExchangeRate = '/Rate/exchangerate';
  String getRates(String s, String r, String uID) =>
      '/Rate?sendingCurrencyCode=$s&receivingCurrencyCode=$r&userid=$uID';
}

class _OTPEndpoints {
  final otp = '/User/RequestVerificationOTP';
}

class _OtherEndpoints {
  final getOccupation = '/Occupation';
  final getQuestionnaireGroupId = '/Questionnaire/group';
  String submitQuestionnaire(int groupId) => '/Questionnaire/answer/$groupId';
  String getQuestionnaires(int groupId) => '/Questionnaire/$groupId';
  String getCountryCountries(int countryType) =>
      '/Country/Countries?CountryType=$countryType';

  final masterMind = '/Settings/userLocation';
}

class _WalletEndpoints {
  final getOccupation = '/Occupation';
  final getOTP = '/User/RequestVerificationOTP';
  final getUserWallets = '/Wallet/userwallets';
  final getFundNgnWalletDetails = '/Transactions/FundNgnWallet';
  final String accountLookup = '/Transactions/accountlookup';

  String getWalletCurrency(String currency) =>
      '/Wallet?walletCurrency=$currency';
  String getTransactions(int pageNumber, int pageSize) =>
      '/v2/user/transactions?pageNumber=$pageNumber&pageSize=$pageSize';
  String sendWithdrawalRequest(String currency) =>
      '/Transactions/$currency/Withdrawal';
  String getInteracDetails(String email) => '/User/InteracDetails?email=$email';

  String getSingleExcRate(
    String sendingCurrencyCode,
    String receivingCurrencyCode, {
    String? userId,
  }) =>
      '/Rate?sendingCurrencyCode=$sendingCurrencyCode&receivingCurrencyCode=$receivingCurrencyCode&userid=$userId';

  String calculateExchangeRate(
    int amount,
    String sendCurrencyCode,
    String receivingCurrencyCode, {
    String? userId,
  }) =>
      '/Rate/calculateExchangerate?AmountToSend=$amount&CurrencyToSend=$sendCurrencyCode&CurrencyToReceive=$receivingCurrencyCode&userId=$userId';

  String getWalletFundingInformation(String currencyCode) =>
      '/$currencyCode/FundingInformation';

  String getVirtualAccounts(String currency) =>
      '/VirtualAccounts?currency=$currency';
  String getVirtualBanks = '/VirtualAccounts/virtual-banks';
  String createVirtualAccount = '/VirtualAccounts/create';

  final getAutoDepositDetails = '/Transactions/autoDepositDetails';

  String postTransactionOtherCurrency(String currency) =>
      '/$currency/transactions';

  String postTransaction = '/v2/Transactions';

  String postTransactionUrl(String receiverCurrencyCode) {
    switch (receiverCurrencyCode.toLowerCase()) {
      case 'ghs':
      case 'usd':
      case 'mxn':
      case 'kes':
      case 'cad':
      case 'xof':
      case 'aud':
      case 'gbp':
      case 'cny':
      case 'eur':
      case 'inr':
        return postTransactionOtherCurrency(receiverCurrencyCode);
      case 'ngn':
        return postTransaction;
      default:
        return postTransaction;
    }
  }

  String downloadAccountStatement({
    required String walletCurrency,
    required String fromDate,
    required String toDate,
    required int fileType,
  }) {
    return '/Wallet/downloadAccountStatement?WalletCurrency=$walletCurrency&FileType=$fileType&FromDate=$fromDate&ToDate=$toDate';
  }

  String getWalletDetailsByHandle(String username) =>
      '/Wallet/get-by-handle?handle=$username';
}

class _SecurityEndpoints {
  final toggle2FA = '/Barcode/UpdateUser2FaStatus';
  final generateBarcode = '/Barcode/GenerateBarcode';
  final deleteUser = '/User';
  final changePassword = '/User/profile/password';
  final getSecurityQuestions = '/SecurityQuestion';
  final setSecurityQuestions = '/User/setUserSecurityQuestion';
  final getRandomSecurityQuestion = '/SecurityQuestion/Random';
  final verifyAnswer = '/SecurityQuestion/verifyAnswer';
  final createPin = '/User/addSecurityPin';
  final resetPin = '/User/resetpin';
  final resetTransactionPin = '/User/SecurityPin';
  final verifyTransactionPin = '/User/VerifyPin';
  final userSkipCount = '/User/userskipcount';
  final appSettings = '/Settings';
}

class _RewardEndPoints {
  // rewards
  String getRewards(String userId) => '/Reward/rewards?userId=$userId';
  String getRewardPointRate(String userId) =>
      '/Reward/pointrate?userId=$userId';
  String redeemRewardPoints = '/Reward/redeempoints';
}

class _BeneficiaryEndpoints {
  final addRecipient = '/User/AddUserBeneficiary';
  final getRecipient = '/User/GetBeneficiaryByUserId';
  final addIntBeneficiary = '/User/InternationalBank';
  String getRecipientById(
    String accountNum,
    String email,
    String bankName,
    String name,
  ) =>
      '/User/GetBeneficiaryByUserId?ReciepientAccountNumber=$accountNum&ReciepientEmailAddress=$email&ReciepientBankName=$bankName&ReciepientName=$name';
  String deleteBeneficiary(int beneficiaryId) =>
      '/User/DeleteUserBeneficiary?beneficiaryId=$beneficiaryId';
}

class _UserTierEndpoints {
  final currentTierDetails = '/User/currentTierDetails';
  final requestTierUpgrade = '/User/requestTierUpgrade';
  final tierUpgradeDocuments = '/Documents/tierUpgradeRequestDocuments';
}

class _BankEndpoints {
  String getBankBranch(String branchCode) =>
      '/Transactions/banksbranch/$branchCode';
  final String accountLookup = '/Transactions/accountlookup';

  String getBanks(
    String countryCode, {
    int? bankVersion,
    int? bankMethod,
  }) {
    if (bankMethod != null) {
      return '/Transactions/banks?countryCode=$countryCode&bankVersion=$bankVersion&bankMethod=$bankMethod';
    }
    return '/Transactions/banks?countryCode=$countryCode&bankVersion=$bankVersion';
  }
}

class _PayBillsEndpoints {
  String searchBillers(String query) => '/Bills/search-biller?query=$query';
  final billsPaymentV2 = '/Bills/v2/pay-bills';
  final validateBillerAccount = '/Bills/validate-account-number';
}

class _AppNotifications {
  String getAllNotifications(int pageNumber) =>
      '/AppNotifications?PageNumber=$pageNumber';
  final getUnreadCount = '/AppNotifications/unread-count';
}

class _PromoEndpoints {
  String verifyPromo(String sendCurrencyCode, String receiveCurrencyCode) =>
      '/Promo/verifyPromo/$sendCurrencyCode/$receiveCurrencyCode';
}
// endpoints

final authEndpoints = _AuthEndpoints();
final transactionEndpoints = _TransactionEndpoints();
final walletEndpoints = _WalletEndpoints();
final userEndpoints = _UserEndpoints();
final documentEndpoints = _DocumentEndpoints();
final rateEndpoints = _RateEndpoints();
final otherEndpoints = _OtherEndpoints();
final otpEndpoints = _OTPEndpoints();
final securityEndpoints = _SecurityEndpoints();
final bankEndpoints = _BankEndpoints();
final rewardEndpoints = _RewardEndPoints();
final beneficiaryEndpoints = _BeneficiaryEndpoints();
final userTierEndpoints = _UserTierEndpoints();
final appNotifications = _AppNotifications();
final payBillsEndpoints = _PayBillsEndpoints();
final promoEndpoints = _PromoEndpoints();
final rewardEndpoint = _RewardEndPoints();
