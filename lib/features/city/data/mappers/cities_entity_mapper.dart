import 'package:weather_test/core/base/base_mapper.dart';
import 'package:weather_test/features/city/data/models/cities_model.dart';
import 'package:weather_test/features/city/data/models/city_model.dart';
import 'package:weather_test/features/city/domain/entities/city_entity.dart';

class CitiesEntityMapper implements EntityMapper<List<CityEntity>, CitiesModel> {
  final EntityMapper<CityEntity, CityModel> _cityEntityMapper;

  const CitiesEntityMapper({
    required EntityMapper<CityEntity, CityModel> cityEntityMapper,
  }) : _cityEntityMapper = cityEntityMapper;

  @override
  List<CityEntity> toEntity(CitiesModel model) {
    return model.data.map(_cityEntityMapper.toEntity).toList();
  }
}
