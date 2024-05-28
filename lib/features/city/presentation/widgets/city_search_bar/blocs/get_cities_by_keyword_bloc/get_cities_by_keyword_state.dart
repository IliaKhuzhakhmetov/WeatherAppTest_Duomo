import 'package:equatable/equatable.dart';
import 'package:weather_test/features/city/domain/entities/city_entity.dart';

class GetCitiesByKeywordState extends Equatable {
  final Iterable<CityEntity> cities;

  const GetCitiesByKeywordState(this.cities);

  @override
  List<Object?> get props => [cities];
}
