import 'package:flutter/foundation.dart' show optionalTypeArgs;

@optionalTypeArgs
abstract class Usecase<I, O> {
  const Usecase();

  O call(I param);
}

abstract class AsyncUsecase<I, O> {
  const AsyncUsecase();

  Future<O> call(I param);
}
