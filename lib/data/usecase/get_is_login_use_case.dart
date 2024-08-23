import 'package:flutter/material.dart';
import 'package:note_app/data/repository/app_repository.dart';
import 'package:note_app/data/usecase/base/base_use_case.dart';

class GetIsLoginUsecase extends BaseSyncUseCase<NoInput, GetIsLoginOutput> {
  final AppRepository _appRepository;

  const GetIsLoginUsecase(this._appRepository);
  @override
  @protected
  GetIsLoginOutput buildUseCase(NoInput input) {
    return GetIsLoginOutput(isFirstLogin: _appRepository.isFirstLogin);
  }
}

class GetIsLoginOutput extends BaseUseCaseOutput {
  final bool isFirstLogin;

  GetIsLoginOutput({required this.isFirstLogin});
}
