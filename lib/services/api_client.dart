import 'dart:convert';
import 'dart:io';
import 'package:currency_converter/models/currency_model.dart';
import 'package:currency_converter/models/rates_model.dart';
import 'package:currency_converter/utils/api_response.dart';
import 'package:currency_converter/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  /// This function will get a currency JSON string from API. Each entry of the JSON string will be a CurrencyModel.
  /// It is then converted to a list of CurrencyModel.
  ///
  /// The result is based on the response statusCode. If it fetches the api successfully,
  /// the object is a Success instance. Otherwise, it is a Failure instance.
  Future<ApiResponse<List<CurrencyModel>>> getCurrencies(http.Client client) async {
    try {
      const currencyListURI = "https://${AppConstants.baseURL}${AppConstants.currenciesURL}";
      final response = await client.get(Uri.parse(currencyListURI));
      if (response.statusCode == 200) {
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

  /// Get the exchange rates based on the base currency that corresponds
  /// to each of other currencies.
  Future<ApiResponse<RatesModel>> getRates(http.Client client, String baseCurrency) async {
    try {
      final exchangeRateURI = "https://${AppConstants.baseURL}${AppConstants.ratesURL}$baseCurrency.json";
      var response = await client.get(Uri.parse(exchangeRateURI));
      if (response.statusCode == 200) {
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
