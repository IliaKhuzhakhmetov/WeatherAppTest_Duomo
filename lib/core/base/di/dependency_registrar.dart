import 'dart:async';

abstract interface class DependencyRegistrar {
  const DependencyRegistrar();
  FutureOr<void> register();
}

abstract mixin class DependencyGetter {
  TypeToGet call<TypeToGet>();
}
