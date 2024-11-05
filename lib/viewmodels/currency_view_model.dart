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
  final currencyPatterns = RegExp(r'^(0|[1-9]\d*)(((,\d{3})*)?(\.\d+)?)$');

  List<String> get abbreviations => _abbreviations;
  String get baseCurrency => _baseCurrency;
  String get targetCurrency => _targetCurrency;
  double get exchangeRate => _exchangeRate;
  double get convertResult => _convertResult;
  String? get errorCode => _errorCode;
  bool get isLoading => _isLoading;
  bool get isValidate => _isValidate;

  /// Initialize app state variable and get currency and exchange rates from repositories.
  Future<void> initData() async {
    _errorCode = null;
    _isLoading = true;

    await setCurrencies();
    await setRates();
    getRate(_targetCurrency);

    _isLoading = false;
    notifyListeners();
  }

  /// Setting the list of abbreviations to be displayed to UI.
  Future<void> setCurrencies() async {
    final response = await currencyRepository.getCurrencies();
    if (response is Success) {
      _currencies = response.data!;
      _abbreviations = _currencies.map((currency) => currency.abbreviation!).toList();
    } else if (response is Error) {
      _errorCode = response.message!;
    }
  }

  /// Set the RatesModel
  Future<void> setRates() async {
    final response = await ratesRepository.getRates(_baseCurrency);
    if (response is Success) {
      ratesModel = response.data!;
    } else if (response is Error) {
      _errorCode = response.message!;
    }
  }

  /// Get an exchange rate to the target currency.
  void getRate(String targetCurrency) {
    if (_errorCode == null) {
      _exchangeRate = ratesModel!.rates[targetCurrency].toDouble();
    }
    notifyListeners();
  }

  /// Swap between two currencies. Since swapping cause the base currency to be changed,
  /// it must call API to get new exchange rates.
  Future<void> swapCurrencies() async {
    String temp = _baseCurrency;
    _baseCurrency = _targetCurrency;
    _targetCurrency = temp;
    await setRates();
    getRate(_targetCurrency);
    computeResult();
    notifyListeners();
  }

  /// Compute the result based on the amount
  void computeResult() {
    _convertResult = _newAmount * _exchangeRate;
    notifyListeners();
  }

  /// Set the input amount to app state
  void setNewAmount(double newAmount) {
    _newAmount = newAmount;
    notifyListeners();
  }

  /// Make a change to the base currency
  Future<void> convertFrom(String newCurrrency) async {
    _baseCurrency = newCurrrency;
    await setRates();
    getRate(_targetCurrency);
    computeResult();
    notifyListeners();
  }

  /// Make a change to the target currency
  void convertTo(String newCurrency) {
    _targetCurrency = newCurrency;
    getRate(_targetCurrency);
    computeResult();
    notifyListeners();
  }

  /// Validate the amount input
  void inputValidate(String input) {
    // It is fine to input nothing.
    if (input.isEmpty) {
      _isValidate = true;
      setNewAmount(0.0);
      notifyListeners();
      return;
    }
    if (currencyPatterns.hasMatch(input)) {
      input = input.replaceAll(RegExp(r','), '');
      double amount = double.parse(input);
      setNewAmount(amount);
      _isValidate = true;
      notifyListeners();
      return;
    }
    _isValidate = false;
    setNewAmount(0.0);
    notifyListeners();
  }
}
