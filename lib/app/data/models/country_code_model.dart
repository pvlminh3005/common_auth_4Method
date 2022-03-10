class CountryCodeModel {
  final String countryCode;
  final String phoneCode;
  final String name;

  CountryCodeModel({
    required this.countryCode,
    required this.phoneCode,
    required this.name,
  });

  static CountryCodeModel fromJson(Map<String, String> data) {
    return CountryCodeModel(
      countryCode: data['countryCode']!,
      phoneCode: data['phoneCode']!,
      name: data['name']!,
    );
  }
}
