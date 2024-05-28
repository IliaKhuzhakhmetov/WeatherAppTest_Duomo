import 'dart:async';

abstract interface class BaseUseCase<ResultType, Params> {
  const BaseUseCase();

  FutureOr<ResultType> call(Params params);
}
