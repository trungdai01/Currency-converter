import 'package:currency_converter/services/api_client.dart';

class RatesRepository {
  ApiClient apiClient = ApiClient();

  Future<dynamic> getRate(String fromCurrency, String toCurrency) async {
    return await apiClient.getRate(fromCurrency, toCurrency);
  }
}
