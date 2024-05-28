import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/features/app/presentation/current_temperature/bloc/get_current_weather_event.dart';
import 'package:weather_test/features/app/presentation/current_temperature/bloc/get_current_weather_state.dart';
import 'package:weather_test/features/weather/domain/usecases/get_current_weather_usecase.dart';

export 'package:weather_test/features/app/presentation/current_temperature/bloc/get_current_weather_event.dart';
export 'package:weather_test/features/app/presentation/current_temperature/bloc/get_current_weather_state.dart';

class GetCurrentWeatherBloc extends Bloc<GetCurrentWeatherEvent, GetCurrentWeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  GetCurrentWeatherBloc({
    required GetCurrentWeatherUseCase getCurrentWeatherUseCase,
  })  : _getCurrentWeatherUseCase = getCurrentWeatherUseCase,
        super(const GetCurrentWeatherInitial()) {
    on<GetCurrentWeatherEvent>(_getCurrentWeather);
  }

  FutureOr<void> _getCurrentWeather(
    GetCurrentWeatherEvent event,
    Emitter<GetCurrentWeatherState> emit,
  ) async {
    if (state is GetCurrentWeatherLoading) return;

    emit(const GetCurrentWeatherLoading());

    try {
      final result = await _getCurrentWeatherUseCase(
        (
          latitude: event.latitude,
          longitude: event.longitude,
        ),
      );

      return emit(GetCurrentWeatherSuccess(result));
    } on Exception catch (exception) {
      emit(GetCurrentWeatherFailure(exception, event.latitude, event.longitude));
      rethrow;
    }
  }
}
