class WeatherMainModel {
  final double temp;

  const WeatherMainModel({required this.temp});

  factory WeatherMainModel.fromMap(Map<String, dynamic> map) {
    return WeatherMainModel(
      temp: map['temp']?.toDouble() ?? 0.0,
    );
  }
}
