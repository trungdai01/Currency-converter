import "dart:convert";

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

Map<String, String> allCurrenciesFromJson(String json) {
  return Map.from(jsonDecode(json)).map(
    (key, value) => MapEntry<String, String>(key, value),
  );
}
