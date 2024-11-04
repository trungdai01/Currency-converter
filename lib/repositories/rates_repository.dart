import 'package:currency_converter/models/rates_model.dart';
import 'package:currency_converter/services/api_client.dart';
import 'package:currency_converter/utils/api_response.dart';

class RatesRepository {
  ApiClient apiClient = ApiClient();

  Future<ApiResponse<RatesModel>> getRates(String baseCurrency) async {
    return await apiClient.getRates(baseCurrency);
  }
}
