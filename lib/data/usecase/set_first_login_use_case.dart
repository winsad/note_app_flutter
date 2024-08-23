import 'package:note_app/data/repository/app_repository.dart';
import 'package:note_app/data/usecase/base/base_use_case.dart';

class SetFirstLoginUseCase extends BaseFutureUseCase<NoInput, NoOutput> {
  const SetFirstLoginUseCase(this._appRepository);

  final AppRepository _appRepository;
  @override
  Future<NoOutput> buildUseCase(NoInput input) async {
    await _appRepository.saveIsFirstLogin(true);
    return const NoOutput();
  }
}
