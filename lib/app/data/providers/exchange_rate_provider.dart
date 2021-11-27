import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeRate {
  final String base;
  final String target;
  final String date;
  final double rate;
  ExchangeRate({required this.base, required this.date, required this.rate, required this.target});

  factory ExchangeRate._fromJson(String base, String target, Map<String, dynamic> json) {
    return ExchangeRate(
      date: json['date'],
      rate: double.tryParse('${json[target]}')!,
      base: base,
      target: target,
    );
  }

  static Future<ExchangeRate> getExchangeRate(String baseCurrency, String targetCurrency) async {
    String base = baseCurrency.toLowerCase();
    String target = targetCurrency.toLowerCase();
    String url = 'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/$base/$target.json';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return ExchangeRate._fromJson(base, target, json.decode(response.body));
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }
}
