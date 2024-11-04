import 'package:currency_converter/models/currency_model.dart';
import 'package:currency_converter/services/api_client.dart';
import 'package:currency_converter/utils/api_response.dart';

class CurrencyRepository {
  ApiClient apiClient = ApiClient();

  Future<ApiResponse<List<CurrencyModel>>> getCurrencies() async {
    return await apiClient.getCurrencies();
  }
}
