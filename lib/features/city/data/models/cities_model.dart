import 'package:weather_test/features/city/data/models/city_model.dart';

class CitiesModel {
  final List<CityModel> data;

  const CitiesModel({required this.data});

  factory CitiesModel.fromMap(Map<String, dynamic> map) {
    return CitiesModel(
      data: List<CityModel>.from(map['data']?.map((x) => CityModel.fromMap(x))),
    );
  }
}
