import 'package:weather_test/core/base/di/dependency_container.dart';
import 'package:weather_test/core/base/di/dependency_registrar.dart';
import 'package:weather_test/core/base/factories/dio_client_factory.dart';
import 'package:weather_test/core/constants.dart';
import 'package:weather_test/features/city/data/datasources/city_remote_datasource.dart';
import 'package:weather_test/features/city/data/datasources/oauth_local_datasource.dart';
import 'package:weather_test/features/city/data/interceptors/amadeus_oauth2_interceptor.dart';
import 'package:weather_test/features/city/data/mappers/cities_entity_mapper.dart';
import 'package:weather_test/features/city/data/mappers/city_entity_mapper.dart';
import 'package:weather_test/features/city/data/repositories/city_repository_impl.dart';
import 'package:weather_test/features/city/domain/repositories/city_repository.dart';
import 'package:weather_test/features/city/domain/usecases/get_cities_by_keyword_usecase.dart';
import 'package:weather_test/features/city/presentation/widgets/city_search_bar/blocs/get_cities_by_keyword_bloc/get_cities_by_keyword_bloc.dart';

class CityDependencyRegistrar implements DependencyRegistrar {
  final DependencyContainer _container;

  const CityDependencyRegistrar({
    required DependencyContainer container,
  }) : _container = container;

  @override
  void register() {
    // Mappers
    _container.register(() => CityEntityMapper());
    _container.register(() => CitiesEntityMapper(
          cityEntityMapper: _container<CityEntityMapper>(),
        ));

    // Interceptors
    _container.register(
      () => AmadeusOAuthInterceptor(
        authLocalDataSource: _container(),
        dotEnv: _container(),
      ),
    );

    // Datasources
    _container.register<OAuthLocalDataSource>(
      () => AmadeusOAuthLocalDataSource(
        flutterSecureStorage: _container(),
      ),
    );
    _container.register<CityRemoteDataSource>(
      () => AmadeusCityRemoteDataSource(
        dio: DioClientFactory.create(
          DioFactorySettings(
            baseUrl: Constants.amadeusBaseUrl,
            interceptors: [
              _container<AmadeusOAuthInterceptor>(),
            ],
          ),
        ),
      ),
    );

    // Repositories
    _container.register<CityRepository>(
      () => CityRepositoryImpl(
        cityRemoteDataSource: _container(),
        citiesEntityMapper: _container<CitiesEntityMapper>(),
      ),
    );

    // UseCases
    _container.register(() => GetCitiesByKeyWordUseCase(cityRepository: _container()));

    // BLoC
    _container.register(() => GetCitiesByKeywordBloc(getCitiesByKeyWordUseCase: _container()));
  }
}
