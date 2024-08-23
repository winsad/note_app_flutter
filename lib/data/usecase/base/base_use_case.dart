import 'package:flutter/foundation.dart';
import 'package:note_app/helpers/logger.dart';

abstract class BaseUseCase<Input, Output> {
  const BaseUseCase();

  Output execute(Input input);
}

abstract class BaseFutureUseCase<I extends BaseUseCaseInput,
    O extends BaseUseCaseOutput> extends BaseUseCase<I, Future<O>> {
  const BaseFutureUseCase();

  @override
  Future<O> execute(I input) async {
    try {
      Logger.d('FutureUseCase $I Input: $input');

      final response = await buildUseCase(input);

      Logger.d('FutureUseCase $I Input: $input');

      return response;
    } catch (e) {
      Logger.e('FutureErrorUseCase $I Error: $e');
      rethrow;
    }
  }

  Future<O> buildUseCase(I input);
}

abstract class BaseSyncUseCase<I extends BaseUseCaseInput,
    O extends BaseUseCaseOutput> extends BaseUseCase<I, O> {
  const BaseSyncUseCase();
  @override
  O execute(I input) {
    try {
      Logger.d('SyncUseCase $I Input: $input');

      final response = buildUseCase(input);

      Logger.d('SyncUseCase $I Output: $response');

      return response;
    } catch (e) {
      Logger.e('SyncErrorUseCase $I Error: $e');
      rethrow;
    }
  }

  O buildUseCase(I input);
}

abstract class BaseStreamUseCase<I extends BaseUseCaseInput, O> {
  const BaseStreamUseCase();

  Stream<O> execute(I input) {
    return buildUseCase(input).handleError((error) {
      Logger.e('StreamErrorUseCase $I Error: $error');
    });
  }

  @protected
  Stream<O> buildUseCase(I input);
}

abstract class BaseUseCaseInput {
  const BaseUseCaseInput();
}

abstract class BaseUseCaseOutput {
  const BaseUseCaseOutput();
}

class NoInput extends BaseUseCaseInput {
  const NoInput();
}

class NoOutput extends BaseUseCaseOutput {
  const NoOutput();
}
