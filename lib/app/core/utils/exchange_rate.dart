import 'package:keepital/app/data/providers/exchange_rate_provider.dart';

abstract class ExchangeMoney {
  static Future<double> exchange(String fromCode, String toCode, double amount) async {
    var rate = await ExchangeRate.getExchangeRate(fromCode, toCode);
    return amount * rate.rate;
  }
}
