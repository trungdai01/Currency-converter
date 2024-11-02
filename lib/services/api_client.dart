import 'dart:convert';
import 'package:currency_converter/models/currency_model.dart';
import 'package:currency_converter/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final Uri currencyListURL = Uri.https(AppConstants.baseURL, AppConstants.currenciesURL);

  Future<List<String>> getCurrencies() async {
    var response = await http.get(currencyListURL);
    if (response.statusCode == 200) {
      var body = allCurrenciesFromJson(response.body);
      List<String> currencyList = (body.keys).toList();
      return currencyList;
    } else {
      throw Exception("Failed to fetch currencies API");
    }
  }

  Future<dynamic> getRate(String fromCurrency, String toCurrency) async {
    final Uri exchangeRateURL = Uri.https(AppConstants.baseURL, "${AppConstants.ratesURL}$fromCurrency.json");
    var response = await http.get(exchangeRateURL);
    if (response.statusCode == 200) {
      //   log(response.body);
      var body = jsonDecode(response.body);
      //   log("$body");
      return body[fromCurrency][toCurrency];
    } else {
      throw Exception("Failed to fetch exchange rate API");
    }
  }
}
