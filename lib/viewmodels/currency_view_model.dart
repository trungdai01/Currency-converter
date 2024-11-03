import 'package:currency_converter/repositories/currency_repository.dart';
import 'package:currency_converter/repositories/rates_repository.dart';
import 'package:flutter/material.dart';

class CurrencyViewModel with ChangeNotifier {
  List<String> _currencies = [];
  String _fromCurrency = "usd";
  String _toCurrency = "vnd";
  double _exchangeRate = 0.0;
  double _convertResult = 0.0;
  double _newAmount = 0.0;
  double get exchangeRate => _exchangeRate;
  List<String> get currencies => _currencies;
  String get fromCurrency => _fromCurrency;
  String get toCurrency => _toCurrency;
  double get convertResult => _convertResult;

  CurrencyRepository currencyRepository = CurrencyRepository();
  RatesRepository ratesRepository = RatesRepository();

  Future<void> setCurrencies() async {
    _currencies = await currencyRepository.getCurrencies();
  }

  Future<void> setRate() async {
    _exchangeRate = await ratesRepository.getRate(_fromCurrency, _toCurrency);
  }

  Future<void> initData() async {
    await setCurrencies();
    await setRate();
    notifyListeners();
  }

  Future<void> swapCurrencies() async {
    String temp = _fromCurrency;
    _fromCurrency = _toCurrency;
    _toCurrency = temp;
    await setRate();
    await computeResult();
    notifyListeners();
  }

  Future<void> computeResult() async {
    _convertResult = _newAmount * _exchangeRate;
    notifyListeners();
  }

  void setNewAmount(double newAmount) {
    _newAmount = newAmount;
  }

  Future<void> convertFrom(String newAmount) async {
    _fromCurrency = newAmount;
    await setRate();
    await computeResult();
    notifyListeners();
  }

  Future<void> convertTo(String newAmount) async {
    _toCurrency = newAmount;
    await setRate();
    await computeResult();
    notifyListeners();
  }
}
