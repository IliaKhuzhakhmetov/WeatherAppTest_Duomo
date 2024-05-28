import 'package:weather_test/features/city/data/models/geo_code_model.dart';

class CityModel {
  final String name;
  final GeoCodeModel geoCode;
  final Map<String, dynamic> address;

  const CityModel({
    required this.name,
    required this.geoCode,
    required this.address,
  });

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      name: map['name'] ?? '',
      geoCode: GeoCodeModel.fromMap(map['geoCode']),
      address: map['address'] ?? {},
    );
  }
}
