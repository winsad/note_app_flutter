import 'package:note_app/data/model/note_entity.dart';
import 'package:note_app/helpers/base/base_bloc.dart';

class DashbardState extends BaseBlocState {
  final List<NoteEntity> notes;
  final bool isLoading;

  const DashbardState({
    this.notes = const <NoteEntity>[],
    this.isLoading = true,
  });

  // copywith
  DashbardState copyWith({
    List<NoteEntity>? notes,
    bool? isLoading,
  }) {
    return DashbardState(
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  // tostring
  // @override
  // String toString() {
  //   return 'DashbardState(notes: $notes, isLoading: $isLoading)';
  // }
}
