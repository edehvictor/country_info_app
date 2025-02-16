class CountriesModel {
  final String commonName;
  final String officialName;
  final String capital;
  final int population;
  final String flagUrl;
  final String continents;
  final String subregion;
  final String independent;
  final double area;
  final String timezones;
  final String currencyName;
  final String firstLanguage;
  final String postCode;
  final String coatOfArm;

  CountriesModel(
      {required this.commonName,
      required this.officialName,
      required this.capital,
      required this.population,
      required this.flagUrl,
      required this.continents,
      required this.subregion,
      required this.independent,
      required this.area,
      required this.timezones,
      required this.currencyName,
      required this.firstLanguage,
      required this.postCode,
      required this.coatOfArm});

  // Convert the methods into static methods
  static String _getFirstCurrencyName(Map<String, dynamic> currencies) {
    if (currencies.isEmpty) return 'N/A';
    String firstKey = currencies.keys.first;
    return currencies[firstKey]['name'] ?? 'Unknown';
  }

  static String _getFirstLanguage(Map<String, dynamic> languages) {
    if (languages.isEmpty) return 'N/A';
    String firstKey = languages.keys.first;
    return languages[firstKey] ?? 'Unknown';
  }

  static String _getpostalCode(Map<String, dynamic> postalCode) {
    if (postalCode.isEmpty) return 'N/A';
    String firstKey = postalCode.keys.first;
    return postalCode[firstKey] ?? 'Unknown';
  }

  factory CountriesModel.fromJson(Map<String, dynamic> json) {
    return CountriesModel(
      commonName: json['name']['common'] ?? '',
      officialName: json['name']['official'] ?? '',
      capital: (json['capital'] as List<dynamic>?)?.first ?? 'No capital',
      population: json['population'] ?? 0,
      flagUrl: json['flags']['png'] ?? '',
      continents:
          (json['continents'] as List<dynamic>?)?.first ?? 'No continent',
      subregion: json['subregion'] ?? '',
      independent: json['independent']?.toString() ?? 'Unknown',
      area: json['area'] ?? 0,
      timezones: (json['timezones'] as List<dynamic>?)?.first ?? 'No capital',
      currencyName: _getFirstCurrencyName(json['currencies'] ?? {}),
      firstLanguage: _getFirstLanguage(json['languages'] ?? {}),
      postCode: _getpostalCode(json['postalCode'] ?? {}),
      coatOfArm: json['coatOfArms']['png'] ?? '',
    );
  }
}
