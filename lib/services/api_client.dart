import 'dart:convert';
import 'dart:io';
import 'package:currency_converter/models/currency_model.dart';
import 'package:currency_converter/models/rates_model.dart';
import 'package:currency_converter/utils/api_response.dart';
import 'package:currency_converter/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final Uri currencyListURL = Uri.https(AppConstants.baseURL, AppConstants.currenciesURL);

  Future<ApiResponse<List<CurrencyModel>>> getCurrencies() async {
    try {
      var response = await http.get(currencyListURL);
      if (response.statusCode >= 200 && response.statusCode <= 209) {
        Map<String, dynamic> body = jsonDecode(response.body);
        List<CurrencyModel> currencies = body.entries.map((entry) => CurrencyModel.fromJson(entry)).toList();
        return ApiResponse.success(currencies);
      } else {
        return ApiResponse.failure(response.reasonPhrase ?? 'Failed to fetch currencies API');
      }
    } on SocketException {
      return ApiResponse.failure("Network failure");
    } on Exception catch (error) {
      return ApiResponse.failure("An error occured $error");
    }
  }

  Future<ApiResponse<RatesModel>> getRates(String baseCurrency) async {
    try {
      final Uri exchangeRateURL = Uri.https(AppConstants.baseURL, "${AppConstants.ratesURL}$baseCurrency.json");
      var response = await http.get(exchangeRateURL);
      if (response.statusCode >= 200 && response.statusCode <= 209) {
        Map<String, dynamic> body = jsonDecode(response.body);
        return ApiResponse.success(RatesModel.fromJson(body));
      } else {
        return ApiResponse.failure(response.reasonPhrase ?? 'Failed to fetch exchange rate API');
      }
    } on SocketException {
      return ApiResponse.failure("Network failure");
    } on Exception catch (error) {
      return ApiResponse.failure("An error occured $error");
    }
  }
}
