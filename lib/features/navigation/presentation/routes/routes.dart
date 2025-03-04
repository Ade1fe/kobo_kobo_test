// lib/features/navigation/presentation/routes/routes.dart
import 'package:kobo_kobo/features/navigation/navigation.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';

class AppRoutes {
  static const root = '/';
  static const splash = '/splash';

  // Onboarding routes
  static const onboarding = '/onboarding';
  static const onboardingSignIn = '/onboarding/login';

  // Auth routes
  static const login = '/login';
  static const forgotPassword = '/login/forgot-password';
  static const forgotPasswordOtp = '/login/forgot-password/otp';
  static const resetPassword = '/login/forgot-password/otp/reset-password';
  static const resetEmailSent = '/login/reset-email-sent';
  static const signUp = '/sign-up';
  static const signUpOtp = '/sign-up/otp';
  static const signUpOtpCountry = '/sign-up/otp/country';
  static const signUpBvn = '/bvn';
  static const bvnPinLock = '/bvn/pin-lock';
  static const lockCreatePin = '/bvn/pin-lock/create-pin';
  static const reasonForKobo = '/reason-for-kobo';
  static const viewTermsOrPolicy = '/login/sign-up/tcPolicy';

  // Tab routes
  static String tab(AfrTab tab) {
    Log().debug('the tab is $tab');
    return '/tab/${tab.toString().split('.').last}';
  }

  // Home tab routes
  static const String home = '/tab/home';
  static const String transGenericReceipt = '/tab/home/receipt';
  static const String bills = '/tab/home/bills';
  static const String billOptions = '/tab/home/bills/options';
  static const String electricityOptionsInputs =
      '/tab/home/bills/options/electricity-inputs';
  static const String electricitySummary =
      '/tab/home/bills/options/electricity-inputs/summary';
  static const String electricitySummaryPin =
      '/tab/home/bills/options/electricity-inputs/pin';
  static const String billOptionsChoice =
      '/tab/home/bills/options/selectedOption';
  static const String billSummary =
      '/tab/home/bills/options/selectedOption/top-summary';
  static const String billSummaryPin =
      '/tab/home/bills/options/selectedOption/pin';
  static const String topUp = '/tab/home/top-up';
  static const String phoneBook = '/tab/home/top-up/phone-book';
  static const String topUpDialog = '/tab/home/top-up/top-up-dialog';
  static const String topUpSummary = '/tab/home/top-up/top-summary';
  static const String topUpSummaryPin = '/tab/home/top-up/top-summary/pin';
  static const String transfer = '/tab/home/transfer';
  static const String bankTransfer = '/tab/home/transfer/bank-transfer';
  static const String bankTransferSummary =
      '/tab/home/transfer/bank-transfer/summary';
  static const String bankTransferSummaryPin =
      '/tab/home/transfer/bank-transfer/summary/transferPin';
  static const String bankTransferDialog =
      '/tab/home/transfer/bank-transfer/transfer-dialog';
  static const String koboTransfer = '/tab/home/transfer/kobo-transfer';
  static const String transferSummary =
      '/tab/home/transfer/kobo-transfer/summary';
  static const String transferDialog =
      '/tab/home/transfer/kobo-transfer/transfer-dialog';
  static const String transferPin =
      '/tab/home/transfer/kobo-transfer/summary/transferPin';

  // Savings routes
  static const String savings = '/tab/home/savings';
  static const String savingsToPin = '/tab/home/savings/pin';
  static const String savingsPinToTransStatus =
      '/tab/home/savings/trans-status';
  static const String savingDetails = '/tab/home/savings/details';
  static const String savingDetailsWithdraw =
      '/tab/home/savings/details/withdraw';
  static const String savingsWithdrawalToPin =
      '/tab/home/savings/details/withdraw/pin';

  // Other tab routes
  static const String cards = '/tab/cards';
  static const String loans = '/tab/loans';
  static const String more = '/tab/more';

  // Loan screen routes
  static const String loanDetails = 'details';
  static const String salLoanPin = 'sal-loan-pin';
  static const String regSalApp = '/tab/loans/reg-sal-app';
  static const String regConApp = '$regSalApp/reg-con-app';
  static const String easyLoanPin = '$loans/easy-loan-pin';
  static const String easyLoanDetailsScreen = 'easy-loan-details-screen';
  static const String easyLoanViewAllPin = 'easy-loan-view-all-pin';
  static const String loanSuccessModal = 'loan-success-modal';
  static const String loanAppForm = 'loan-app-form';
  static const String loanAppPinloan = 'loan-app-pin-loan';

  // notifivations screen routes
  static const String notificationRoute = '/tab/home/notification-route';
  static const String loanStatusScreen = 'loan-status-screen';
  static const String guarantorsPin = 'guarantors-pin';

  // Helper method to generate full loan route paths
  static String loanRoute(String subRoute) => '$loans/$subRoute';

  // More tab routes
  // static const String more = '/tab/more';
  static const String moreChangePassword = 'change-password';
  static const String moreChangePasswordNamed = 'more_change_password';
  static const String morePinReset = 'pin-reset';
  static const String morePinResetNamed = 'more_pin_reset';
  static const String moreAccountStatement = 'account-statement';
  static const String moreAccountStatementNamed = 'more_account_statement';
  static const String moreEmploymentDetails = 'employment-details';
  static const String moreEmploymentDetailsNamed = 'more_employment_details';
  static const String moreChangeTransactionPin = 'change-transaction-pin';
  static const String moreChangeTransactionPinNamed =
      'more_change_transaction_pin';
}
