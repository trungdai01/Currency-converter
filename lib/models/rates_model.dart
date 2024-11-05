class RatesModel {
  final String date;
  final String baseCurrency;
  final Map<String, dynamic> rates;

  RatesModel({required this.date, required this.baseCurrency, required this.rates});

  factory RatesModel.fromJson(Map<String, dynamic> json) {
    String baseCurrency = json.keys.firstWhere((key) => key != 'date');

    Map<String, dynamic> rates = json[baseCurrency]; // since the Map of exchange rates is a value of the baseCurrency in the JSON string.
    return RatesModel(
      date: json['date'],
      baseCurrency: baseCurrency,
      rates: rates,
    );
  }
}
