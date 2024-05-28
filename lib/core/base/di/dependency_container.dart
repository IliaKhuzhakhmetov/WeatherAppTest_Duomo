import 'package:weather_test/core/base/di/service_descriptor.dart';

abstract interface class DependencyContainer {
  void register<T>(
    T Function() factory, {
    LifeTime lifeTime = LifeTime.singleton,
    bool lazy = true,
  });
  T call<T>();
}

class MapDependencyContainer implements DependencyContainer {
  final _services = <Type, ServiceDescriptor>{};

  @override
  void register<T>(
    T Function() factory, {
    LifeTime lifeTime = LifeTime.singleton,
    bool lazy = true,
  }) {
    final descriptor = ServiceDescriptor<T>(
      factory: factory,
      lifeTime: lifeTime,
      lazy: lazy,
    );
    _services[T] = descriptor;

    if (!lazy && lifeTime == LifeTime.singleton) {
      descriptor.instance;
    }
  }

  @override
  T call<T>() {
    final descriptor = _services[T];
    if (descriptor == null) throw Exception('Service of type $T not found');

    if (descriptor.lifeTime == LifeTime.singleton) {
      return descriptor.instance;
    } else {
      return descriptor.factory();
    }
  }
}
