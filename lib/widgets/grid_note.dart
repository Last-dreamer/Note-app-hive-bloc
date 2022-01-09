import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_todo_bloc/bloc/bloc/note_bloc.dart';
import 'package:hive_todo_bloc/screens/edit_note_screen.dart';
import 'package:hive_todo_bloc/widgets/note_card.dart';

class GridNote extends StatelessWidget {
  final AllNotes state;
  const GridNote({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: state.notes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 2.0,
        ),
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditNoteScreen(
                            note: state.notes[index],
                            index: index,
                            newNote: false,
                          ))),
              child: NoteCard(
                title: state.notes[index].title ?? "",
                content: state.notes[index].content ?? "",
                index: index,
              ));
        });
  }
}
