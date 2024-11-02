import "dart:convert";

Map<String, String> allCurrenciesFromJson(String json) {
  return Map.from(jsonDecode(json)).map(
    (key, value) => MapEntry<String, String>(key, value),
  );
}
