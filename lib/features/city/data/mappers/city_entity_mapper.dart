import 'package:weather_test/core/base/base_mapper.dart';
import 'package:weather_test/features/city/data/models/city_model.dart';
import 'package:weather_test/features/city/domain/entities/city_entity.dart';

class CityEntityMapper implements EntityMapper<CityEntity, CityModel> {
  @override
  CityEntity toEntity(CityModel model) {
    return CityEntity(
      name: model.name,
      latitude: model.geoCode.latitude,
      longitude: model.geoCode.longitude,
      address: model.address.values.join(', '),
    );
  }
}
