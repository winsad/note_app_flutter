import 'package:flutter/material.dart';
import 'package:note_app/data/repository/app_repository.dart';
import 'package:note_app/data/usecase/base/base_use_case.dart';

class SaveThemeModeUseCase
    extends BaseFutureUseCase<SaveThemeModeInput, NoOutput> {
  const SaveThemeModeUseCase(this._appRepository);

  final AppRepository _appRepository;

  @override
  Future<NoOutput> buildUseCase(SaveThemeModeInput input) async {
    await _appRepository.saveThemeMode(input.themeMode);

    return const NoOutput();
  }
}

class SaveThemeModeInput extends BaseUseCaseInput {
  final ThemeMode themeMode;
  const SaveThemeModeInput(this.themeMode);
}
