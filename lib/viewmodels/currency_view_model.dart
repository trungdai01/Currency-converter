import 'package:currency_converter/models/currency_model.dart';
import 'package:currency_converter/models/rates_model.dart';
import 'package:currency_converter/repositories/currency_repository.dart';
import 'package:currency_converter/repositories/rates_repository.dart';
import 'package:currency_converter/utils/api_response.dart';
import 'package:flutter/material.dart';

class CurrencyViewModel extends ChangeNotifier {
  CurrencyRepository currencyRepository = CurrencyRepository();
  RatesRepository ratesRepository = RatesRepository();

  List<String> _abbreviations = [];
  List<CurrencyModel> _currencies = [];
  RatesModel? ratesModel;

  String _baseCurrency = "usd";
  String _targetCurrency = "vnd";
  double _exchangeRate = 0.0;
  double _convertResult = 0.0;
  double _newAmount = 0.0;
  String? _errorCode;
  bool _isLoading = false;
  bool _isValidate = true;
  final currencyPatterns = [
    RegExp(r'0|[1-9]\d{0,2}(,\d{3})*|[1-9]\d*'),
    // RegExp(r'^(\d{1,3}(,\d{3})*|\d+)(\.\d+)'),
    RegExp(r'^\.\d+'),
  ];

  List<String> get abbreviations => _abbreviations;
  String get baseCurrency => _baseCurrency;
  String get targetCurrency => _targetCurrency;
  double get exchangeRate => _exchangeRate;
  double get convertResult => _convertResult;
  String? get errorCode => _errorCode;
  bool get isLoading => _isLoading;
  bool get isValidate => _isValidate;

  Future<void> initData() async {
    _errorCode = null;
    _isLoading = true;

    await setCurrencies();
    await setRates();
    getRate(_targetCurrency);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> setCurrencies() async {
    final response = await currencyRepository.getCurrencies();
    if (response is Success) {
      _currencies = response.data!;
      _abbreviations = _currencies.map((currency) => currency.abbreviation!).toList();
    } else if (response is Error) {
      _errorCode = response.message!;
    }
  }

  Future<void> setRates() async {
    final response = await ratesRepository.getRates(_baseCurrency);
    if (response is Success) {
      ratesModel = response.data!;
    } else if (response is Error) {
      _errorCode = response.message!;
    }
  }

  void getRate(String targetCurrency) {
    _exchangeRate = ratesModel!.rates[targetCurrency].toDouble();
    notifyListeners();
  }

  Future<void> swapCurrencies() async {
    String temp = _baseCurrency;
    _baseCurrency = _targetCurrency;
    _targetCurrency = temp;
    await setRates();
    getRate(_targetCurrency);
    computeResult();
    notifyListeners();
  }

  void computeResult() {
    _convertResult = _newAmount * _exchangeRate;
    notifyListeners();
  }

  void setNewAmount(double newAmount) {
    _newAmount = newAmount;
    notifyListeners();
  }

  Future<void> convertFrom(String newCurrrency) async {
    _baseCurrency = newCurrrency;
    await setRates();
    getRate(_targetCurrency);
    computeResult();
    notifyListeners();
  }

  void convertTo(String newCurrency) {
    _targetCurrency = newCurrency;
    getRate(_targetCurrency);
    computeResult();
    notifyListeners();
  }

  void inputValidate(String input) {
    for (var pattern in currencyPatterns) {
      if (pattern.hasMatch(input)) {
        if (input.startsWith('.')) {
          input = "0$input";
        }
        input = input.replaceAll(RegExp(r','), '');
        double amount = double.parse(input);
        setNewAmount(amount);
        _isValidate = true;
        notifyListeners();
        return;
      }
    }
    _isValidate = false;
    setNewAmount(0.0);
    notifyListeners();
  }
}
