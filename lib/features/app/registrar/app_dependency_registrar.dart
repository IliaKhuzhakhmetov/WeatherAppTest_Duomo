import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_test/core/base/di/dependency_container.dart';
import 'package:weather_test/core/base/di/dependency_registrar.dart';
import 'package:weather_test/features/city/registrar/city_dependency_registrar.dart';
import 'package:weather_test/features/weather/registrar/weather_dependency_registrar.dart';

class AppDependencyRegistrar with DependencyGetter implements DependencyRegistrar {
  final DependencyContainer _container;

  const AppDependencyRegistrar({
    required DependencyContainer container,
  }) : _container = container;

  @override
  FutureOr<void> register() async {
    final dotenv = DotEnv();
    await dotenv.load();

    _container.register(() => dotenv);
    _container.register(() => const FlutterSecureStorage());

    final registrars = [
      WeatherDependencyRegistrar(container: _container),
      CityDependencyRegistrar(container: _container),
    ];

    for (final registrar in registrars) {
      registrar.register();
    }
  }

  @override
  TypeToGet call<TypeToGet>() => _container<TypeToGet>();
}
