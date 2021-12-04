import 'package:dio/dio.dart';
import 'package:keepital/app/core/values/app_value.dart';

class ExchangeRate {
  static String baseCurrency = AppValue.baseCurrency.toLowerCase();
  static String? date;
  static Map<String, num> rates = {};
  static get hasExchangeRate => rates.isNotEmpty;

  static double exchange(String origin, String target, double amount) {
    if (!hasExchangeRate) {
      return amount;
    }
    origin = origin.toLowerCase();
    target = target.toLowerCase();
    if (origin == baseCurrency) {
      return amount * rates[target]!;
    }
    return amount * rates[target]! / rates[origin]!;
  }

  static double getRate(String origin, String target) {
    if (!hasExchangeRate) {
      return 1;
    }
    origin = origin.toLowerCase();
    target = target.toLowerCase();
    if (origin == baseCurrency) {
      return rates[target]!.toDouble();
    }
    return rates[target]! / rates[origin]!;
  }

  static Future<bool> fetchExchangeRate() async {
    String url = UrlValue.exchangeRateUrl;
    var response;
    try {
      response = await Dio().get(url);
      Map<String, dynamic> data = response.data;
      if (response.statusCode == 200) {
        date = data['date'];
        rates = data[baseCurrency].cast<String, num>();
        return true;
      }
    } on Exception {
      throw Exception('Failed to load exchange rate.');
    }
    return false;
  }
}
