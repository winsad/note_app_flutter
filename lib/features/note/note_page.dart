import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/features/note/bloc/note_bloc.dart';
import 'package:note_app/features/note/bloc/note_event.dart';
import 'package:note_app/features/note/bloc/note_state.dart';
import 'package:note_app/helpers/base/base_page_state.dart';
import 'package:note_app/helpers/logger.dart';
import 'package:note_app/helpers/utils/extensions.dart';
import 'package:note_app/helpers/widgets/app_padding.dart';
import 'package:note_app/helpers/widgets/app_sized_box.dart';
import 'package:note_app/helpers/widgets/common_text_field.dart';

class NotePage extends StatefulWidget {
  final int? id;
  // final String? id;
  const NotePage({super.key, required this.id});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends BasePageState<NotePage, NoteBloc> {
  @override
  void initState() {
    bloc.add(OnInitial(id: widget.id));

    super.initState();
  }

  @override
  void onStateChange(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      bloc.add(OnSaveNote());
      Logger.d('On state change');
    }
    super.onStateChange(state);
  }

  @override
  Widget buildPage(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => {
        bloc.add(OnSaveNote()),
        Logger.d('On did pop'),
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<NoteBloc, NoteState>(
            buildWhen: (previous, current) => previous.id != current.id,
            builder: (context, state) {
              return Text(state.id != null ? 'Note Detail' : 'New Note');
            },
          ),
        ),
        body: _buildNoteBody(context),
        // body: _buildNormalForm(context),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildNormalForm(BuildContext context) {
    return AppPadding.mid(
      child: Column(
        children: [
          TextField(
            controller: bloc.titleController,
            decoration: const InputDecoration(
              hintText: '',
            ),
            onChanged: (value) => bloc.add(OnTitleFieldChanged(title: value)),
          ),
          AppSizedBox.mid(),
          TextField(
            controller: bloc.descriptionController,
            decoration: const InputDecoration(
              hintText: '',
            ),
            onChanged: (value) =>
                bloc.add(OnDescriptionFieldChanged(description: value)),
          ),
        ],
      ),
    );
  }

  // build new widget
  Widget _buildNoteBody(BuildContext context) {
    return SingleChildScrollView(
      child: SelectionArea(
        child: Column(
          children: [
            BlocBuilder<NoteBloc, NoteState>(
                buildWhen: (previous, current) =>
                    previous.titleHint != current.titleHint,
                builder: (context, state) {
                  return CommonTextField(
                    hintText: state.titleHint,
                    controller: bloc.titleController,
                    hintStyle: context.textTheme.headlineSmall,
                    textStyle: context.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) => bloc.add(
                      OnTitleFieldChanged(title: value),
                    ),
                  );
                }),
            const SizedBox(height: 10),
            BlocBuilder<NoteBloc, NoteState>(
              buildWhen: (previous, current) =>
                  previous.descriptionHint != current.descriptionHint,
              builder: (context, state) {
                return CommonTextField(
                  hintText: state.descriptionHint,
                  controller: bloc.descriptionController,
                  hintStyle: context.textTheme.bodyLarge,
                  textStyle: context.textTheme.bodyLarge,
                  onChanged: (value) => bloc.add(
                    OnDescriptionFieldChanged(description: value),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
