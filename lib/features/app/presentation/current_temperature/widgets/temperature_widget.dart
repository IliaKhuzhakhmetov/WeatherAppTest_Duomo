import 'package:flutter/material.dart';
import 'package:weather_test/features/weather/domain/entities/weather_entity.dart';

class TemperatureWidget extends StatelessWidget {
  final WeatherEntity weather;

  const TemperatureWidget({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {
    final degreesStyle = Theme.of(context).textTheme.displayMedium;
    final trailingSymbol = weather.temperature > 0 ? '+' : '';

    return Column(
      children: [
        const Text('Now'),
        Text(
          '$trailingSymbol${weather.temperature.ceil()}',
          style: degreesStyle,
        ),
      ],
    );
  }
}
