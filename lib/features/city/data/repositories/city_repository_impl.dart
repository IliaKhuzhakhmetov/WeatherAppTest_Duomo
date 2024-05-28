import 'package:weather_test/core/base/base_mapper.dart';
import 'package:weather_test/features/city/data/datasources/city_remote_datasource.dart';
import 'package:weather_test/features/city/data/models/cities_model.dart';
import 'package:weather_test/features/city/domain/entities/city_entity.dart';
import 'package:weather_test/features/city/domain/repositories/city_repository.dart';

class CityRepositoryImpl implements CityRepository {
  final CityRemoteDataSource _cityRemoteDataSource;

  final EntityMapper<List<CityEntity>, CitiesModel> _citiesEntityMapper;

  const CityRepositoryImpl({
    required CityRemoteDataSource cityRemoteDataSource,
    required EntityMapper<List<CityEntity>, CitiesModel> citiesEntityMapper,
  })  : _cityRemoteDataSource = cityRemoteDataSource,
        _citiesEntityMapper = citiesEntityMapper;

  @override
  Future<List<CityEntity>> getCitiesByKeyword(String keyword) async {
    // TODO: Catch amadeus errors [400] with codes
    final result = await _cityRemoteDataSource.getCitiesByKeyword(keyword);

    return _citiesEntityMapper.toEntity(result);
  }
}
