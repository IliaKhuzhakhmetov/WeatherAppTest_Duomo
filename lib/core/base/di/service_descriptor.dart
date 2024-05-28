enum LifeTime {
  singleton,
  transient,
}

class ServiceDescriptor<T> {
  final T Function() factory;
  final LifeTime lifeTime;
  final bool lazy;
  T? _instance;

  ServiceDescriptor({
    required this.factory,
    required this.lifeTime,
    this.lazy = true,
  });

  T get instance {
    _instance ??= factory();
    return _instance!;
  }
}
