class RatesModel {
  final String date;
  final String baseCurrency;
  final Map<String, dynamic> rates;

  RatesModel({required this.date, required this.baseCurrency, required this.rates});

  factory RatesModel.fromJson(Map<String, dynamic> json) {
    String baseCurrency = json.keys.firstWhere((key) => key != 'date');

    Map<String, dynamic> rates = json[baseCurrency];
    return RatesModel(
      date: json['date'],
      baseCurrency: baseCurrency,
      rates: rates,
    );
  }
}
