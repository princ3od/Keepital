class AppValue {
  static const homeTabIndex = 0;
  static const reportTabIndex = 1;
  static const unusedTabIndex = 2;
  static const planningTabIndex = 3;
  static const profileTabIndex = 4;

  static const userCollectionPath = 'users';
  static const categoryPath = 'categories';
  static const walletCollectionPath = 'wallets';
  static const transactionCollectionPath = 'transactions';

  static const favoritedCurrencies = ['VND', 'USD'];
  static const delayTime = Duration(milliseconds: 500);
}

class FormatValue {
  static const fullDateFormat = 'dd MMMM, yyyy';
  static const monthReducedDateFormat = 'dd MMM, yyyy';
  static const numbericDateFormat = 'dd/MM/yyyy';
}
