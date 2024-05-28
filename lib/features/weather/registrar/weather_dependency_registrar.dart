import 'package:weather_test/core/base/di/dependency_container.dart';
import 'package:weather_test/core/base/di/dependency_registrar.dart';
import 'package:weather_test/core/base/di/service_descriptor.dart';
import 'package:weather_test/core/base/factories/dio_client_factory.dart';
import 'package:weather_test/core/constants.dart';
import 'package:weather_test/features/app/presentation/current_temperature/bloc/get_current_weather_bloc.dart';
import 'package:weather_test/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:weather_test/features/weather/data/mappers/weather_entity_mapper.dart';
import 'package:weather_test/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_test/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_test/features/weather/domain/usecases/get_current_weather_usecase.dart';

class WeatherDependencyRegistrar implements DependencyRegistrar {
  final DependencyContainer _container;

  const WeatherDependencyRegistrar({required DependencyContainer container})
      : _container = container;

  @override
  void register() {
    // Mappers
    _container.register(() => WeatherEntityMapper());

    // Datasources
    _container.register<WeatherRemoteDataSource>(
      () => OpenWeatherRemoteDataSourceImpl(
        dio: DioClientFactory.create(
          const DioFactorySettings(baseUrl: Constants.openWeatherBaseUrl),
        ),
        dotenv: _container(),
      ),
    );

    // Repositories
    _container.register<WeatherRepository>(() => WeatherRepositoryImpl(
          weatherRemoteDataSource: _container(),
          weatherEntityMapper: _container<WeatherEntityMapper>(),
        ));

    // UseCases
    _container.register(() => GetCurrentWeatherUseCase(
          weatherRepository: _container(),
        ));

    // BLoC
    _container.register(
      () => GetCurrentWeatherBloc(getCurrentWeatherUseCase: _container()),
      lifeTime: LifeTime.transient,
    );
  }
}
