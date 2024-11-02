import 'package:currency_converter/repositories/currency_repository.dart';
import 'package:currency_converter/repositories/rates_repository.dart';
import 'package:flutter/material.dart';

class CurrencyProvider with ChangeNotifier {
  List<String> _currencies = [];
  String fromCurrency = "usd";
  String toCurrency = "eur";
  double _exchangeRate = 0.0;
  double _convertResult = 0.0;
  double get exchangeRate => _exchangeRate;
  List<String> get currencies => _currencies;
  double get convertResult => _convertResult;

  CurrencyRepository currencyRepository = CurrencyRepository();
  RatesRepository ratesRepository = RatesRepository();

  Future<void> getCurrencies() async {
    _currencies = await currencyRepository.getCurrencies();
  }

  Future<void> getRate() async {
    _exchangeRate = await ratesRepository.getRate(fromCurrency, toCurrency);
  }

  Future<void> initData() async {
    await getCurrencies();
    await getRate();
    notifyListeners();
  }

  Future<void> swapCurrencies() async {
    String temp = fromCurrency;
    fromCurrency = toCurrency;
    toCurrency = temp;
    await getRate();
    notifyListeners();
  }

  void computeResult(double value) {
    _convertResult = value * _exchangeRate;
  }

  Future<void> convertFrom(String newValue) async {
    fromCurrency = newValue;
    await getRate();
    notifyListeners();
  }

  Future<void> convertTo(String newValue) async {
    toCurrency = newValue;
    await getRate();
    notifyListeners();
  }
}
