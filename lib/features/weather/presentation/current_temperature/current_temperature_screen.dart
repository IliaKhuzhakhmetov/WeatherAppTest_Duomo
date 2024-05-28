import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/core/base/di/dependency_service.dart';
import 'package:weather_test/features/weather/presentation/current_temperature/bloc/get_current_weather_bloc.dart';
import 'package:weather_test/features/weather/presentation/current_temperature/widgets/temperature_widget.dart';
import 'package:weather_test/features/city/domain/entities/city_entity.dart';
import 'package:weather_test/features/city/presentation/widgets/city_search_bar/city_search_bar.dart';

class CurrentTemperatureScreen extends StatelessWidget {
  const CurrentTemperatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dependencyGetter = DependencyService.of(context);

    return BlocProvider<GetCurrentWeatherBloc>(
      create: (_) => dependencyGetter(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Weather app test')),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              BlocBuilder<GetCurrentWeatherBloc, GetCurrentWeatherState>(
                builder: (context, state) => CitySearchBar(
                  onCitySelected: (city) => _onCitySelected(context, city),
                ),
              ),
              const Spacer(),
              BlocBuilder<GetCurrentWeatherBloc, GetCurrentWeatherState>(
                builder: (context, state) {
                  return switch (state) {
                    GetCurrentWeatherInitial() => const Text(
                        'Select a city',
                      ),
                    GetCurrentWeatherLoading() => const CircularProgressIndicator.adaptive(),
                    GetCurrentWeatherSuccess(:final weatherEntity) => TemperatureWidget(
                        weather: weatherEntity,
                      ),
                    GetCurrentWeatherFailure(:final latitude, :final longitude) => ElevatedButton(
                        onPressed: () => _retryGetWeather(context, latitude, longitude),
                        child: const Text('Retry'),
                      ),
                  };
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _onCitySelected(BuildContext context, CityEntity city) =>
      _getWeatherByLocation(context, city.latitude, city.longitude);

  void _retryGetWeather(
    BuildContext context,
    double latitude,
    double longitude,
  ) =>
      _getWeatherByLocation(context, latitude, longitude);

  void _getWeatherByLocation(BuildContext context, double latitude, double longitude) {
    context.read<GetCurrentWeatherBloc>().add(
          GetCurrentWeatherEvent(latitude, longitude),
        );
  }
}
