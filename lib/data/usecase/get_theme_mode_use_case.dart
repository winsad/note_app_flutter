import 'package:flutter/material.dart';

import '../repository/app_repository.dart';
import 'base/base_use_case.dart';

class GetThemeModeUsecase extends BaseSyncUseCase<NoInput, GetThemeModeOutput> {
  GetThemeModeUsecase(this._appRepository);

  final AppRepository _appRepository;
  @override
  GetThemeModeOutput buildUseCase(NoInput input) {
    final themeMode = _appRepository.themeMode;
    return GetThemeModeOutput(themeMode);
  }
}

class GetThemeModeInput extends BaseUseCaseInput {
  const GetThemeModeInput();
}

class GetThemeModeOutput extends BaseUseCaseOutput {
  final ThemeMode themeMode;
  const GetThemeModeOutput(this.themeMode);
}
