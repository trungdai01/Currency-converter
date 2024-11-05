import 'package:currency_converter/services/api_client.dart';
import 'package:currency_converter/utils/api_response.dart';
import 'package:currency_converter/utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('getCurrencies', () {
    final apiClient = ApiClient();
    test('return a Success instance', () async {
      final client = MockClient();

      when(client.get(Uri.parse("https://${AppConstants.baseURL}${AppConstants.currenciesURL}")))
          .thenAnswer((_) async => http.Response('{"100sat":""}', 200));
      expect(await apiClient.getCurrencies(client), isA<Success>());
    });

    test('return an Error instance', () async {
      final client = MockClient();

      when(client.get(Uri.parse("https://${AppConstants.baseURL}${AppConstants.currenciesURL}")))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(await apiClient.getCurrencies(client), isA<Error>());
    });
  });

  group('getExchangeRates', () {
    final apiClient = ApiClient();
    const baseCurrency = "usd";
    const exchangeRateURI = "https://${AppConstants.baseURL}${AppConstants.ratesURL}$baseCurrency.json";
    test('return a Success instance', () async {
      final client = MockClient();

      when(client.get(Uri.parse(exchangeRateURI))).thenAnswer((_) async => http.Response(
          '{"date": "2024-11-05", "eur": { "1000sats": 5493.03680361, "1inch": 4.780868, "aave": 0.0084907446, "ada": 3.32764139, "aed": 3.99365357, "afn": 72.8073458, "agix": 2.23735788, "akt": 0.50443626, "algo": 9.9322552, "all": 98.2256509, "amd": 421.03053493, "amp": 315.87555783, "ang": 1.95642647,"aoa": 998.42206998}}',
          200));
      expect(await apiClient.getRates(client, baseCurrency), isA<Success>());
    });

    test('return an Error instance', () async {
      final client = MockClient();

      when(client.get(Uri.parse(exchangeRateURI))).thenAnswer((_) async => http.Response('Not Found', 404));
      expect(await apiClient.getRates(client, baseCurrency), isA<Error>());
    });
  });
}
