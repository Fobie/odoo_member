class Country {
  final int id;
  final String name;
  final String code;
  final int phoneCode;

  factory Country.fromJson(Map<String, dynamic> country) => Country(
        id: country["id"],
        name: country["name"],
        code: country["code"],
        phoneCode: country["phone_code"],
      );

  Country(
      {required this.id,
      required this.name,
      required this.code,
      required this.phoneCode});
}

class CountryData {
  List<Country> countryList;
  CountryData({required this.countryList});
}
