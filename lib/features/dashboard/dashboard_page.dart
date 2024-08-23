import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/data/model/note_entity.dart';
import 'package:note_app/features/dashboard/dashboard_bloc/dashboard_bloc.dart';
import 'package:note_app/features/dashboard/dashboard_bloc/dashboard_event.dart';
import 'package:note_app/features/dashboard/dashboard_bloc/dashboard_state.dart';
import 'package:note_app/features/dashboard/widget/theme_mode_icon_widget.dart';
import 'package:note_app/helpers/base/base_page_state.dart';
import 'package:note_app/helpers/base/note_change_observer.dart';
import 'package:note_app/helpers/widgets/loading_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends BasePageState<DashboardPage, DashboardBloc>
    implements NoteChangeObserver {
  @override
  void initState() {
    bloc.add(const OnStreamNote());
    appBloc.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    appBloc.removeObserver(this);
    super.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        centerTitle: true,
        actions: const [ThemeModeIconWidget()],
      ),
      body: Center(
        child: BlocBuilder<DashboardBloc, DashbardState>(
          buildWhen: (previous, current) => previous.notes != current.notes,
          builder: (context, state) {
            if (state.isLoading) {
              return const LoadingWidget();
            }

            if (state.notes.isEmpty) {
              return const Text('No Notes');
            }

            return RefreshIndicator(
              onRefresh: () async {
                bloc.add(const OnInitial());
              },
              child: ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/note',
                      arguments: state.notes[index].id,
                    ),
                    child: ListTile(
                      title: Text(state.notes[index].title),
                      subtitle: Text(
                        state.notes[index].description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: ShapeBorder.lerp(
          const CircleBorder(),
          const StadiumBorder(),
          0.5,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/note', arguments: null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void notifyChanged(List<NoteEntity> notes) {
    bloc.add(OnNotesLoaded(notes: notes));
  }
}
