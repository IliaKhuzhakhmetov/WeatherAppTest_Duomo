import 'package:equatable/equatable.dart';
import 'package:weather_test/features/weather/domain/entities/weather_entity.dart';

sealed class GetCurrentWeatherState {
  const GetCurrentWeatherState();

  bool get isLoading => this is GetCurrentWeatherLoading;
}

class GetCurrentWeatherInitial extends GetCurrentWeatherState {
  const GetCurrentWeatherInitial();
}

class GetCurrentWeatherLoading extends GetCurrentWeatherState {
  const GetCurrentWeatherLoading();
}

class GetCurrentWeatherSuccess extends GetCurrentWeatherState with EquatableMixin {
  final WeatherEntity weatherEntity;

  const GetCurrentWeatherSuccess(this.weatherEntity);

  @override
  List<Object?> get props => [weatherEntity];
}

class GetCurrentWeatherFailure extends GetCurrentWeatherState with EquatableMixin {
  final double latitude;
  final double longitude;
  final Exception exception;

  const GetCurrentWeatherFailure(
    this.exception,
    this.latitude,
    this.longitude,
  );

  @override
  List<Object?> get props => [exception.toString(), exception.runtimeType, latitude, longitude];
}
