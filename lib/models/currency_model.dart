class CurrencyModel {
  final String? abbreviation;
  final String? name;

  CurrencyModel({required this.abbreviation, required this.name});

  factory CurrencyModel.fromJson(MapEntry<String, dynamic> json) {
    return CurrencyModel(
      abbreviation: json.key,
      name: json.value,
    );
  }
}
