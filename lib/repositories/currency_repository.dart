import 'package:currency_converter/services/api_client.dart';

class CurrencyRepository {
  ApiClient apiClient = ApiClient();

  Future<List<String>> getCurrencies() async {
    return await apiClient.getCurrencies();
  }
}
