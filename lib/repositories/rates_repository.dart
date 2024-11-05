import 'package:currency_converter/models/rates_model.dart';
import 'package:currency_converter/services/api_client.dart';
import 'package:currency_converter/utils/api_response.dart';
import 'package:http/http.dart';

class RatesRepository {
  ApiClient apiClient = ApiClient();
  var client = Client();

  /// Holds the RatesModel data.
  Future<ApiResponse<RatesModel>> getRates(String baseCurrency) async {
    return await apiClient.getRates(client, baseCurrency);
  }
}
