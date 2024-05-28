import 'package:weather_test/features/weather/data/models/weather_main_model.dart';

class WeatherModel {
  final WeatherMainModel main;

  const WeatherModel({required this.main});

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      main: WeatherMainModel.fromMap(map['main']),
    );
  }
}
