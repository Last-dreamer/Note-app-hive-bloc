import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_todo_bloc/bloc/bloc/note_bloc.dart';
import 'package:hive_todo_bloc/screens/edit_note_screen.dart';
import 'package:hive_todo_bloc/widgets/grid_note.dart';
import 'package:hive_todo_bloc/widgets/note_card.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NoteBloc>(context).add(NoteInitialEvent());

    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFBB034),
              Color(0xFFF78E1E),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text('Hive Todo'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<NoteBloc, NoteState>(builder: (context, state) {
                  if (state is NoteInitial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is NoteLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is AllNotes) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.90,
                      child: GridNote(
                        state: state,
                      ),
                    );
                  }

                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFFFBB034),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditNoteScreen(
                    newNote: true,
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}
