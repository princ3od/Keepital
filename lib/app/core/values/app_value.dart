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
  static const eventCollectionPath = 'events';

  static const favoritedCurrencies = ['VND', 'USD'];
  static const baseCurrency = 'usd';
  static const delayTime = Duration(milliseconds: 500);
}

class FormatValue {
  static const fullDateFormat = 'dd MMMM, yyyy';
  static const monthReducedDateFormat = 'dd MMM, yyyy';
  static const numbericDateFormat = 'dd/MM/yyyy';
  static const onlyDateFormat = 'dd';
  static const dayFormat = 'EEEE';
  static const fullMonthFormat = 'MMMM, yyyy';
  static const shortMonthFormat = 'MM/yyyy';
  static const dayInMonthFormat = 'dd/MM';
  static const yearFormat = 'yyyy';
  static const monthNDayFormat = 'MMMM, yyyy, EEEE';
}

class UrlValue {
  static const exchangeRateUrl = 'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/${AppValue.baseCurrency}.min.json';
}
