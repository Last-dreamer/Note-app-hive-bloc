import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_todo_bloc/bloc/bloc/note_bloc.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final int index;
  const NoteCard(
      {required this.title, required this.content, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Card(
        color: Colors.amber,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 0, left: 5, right: 5),
          child: Stack(
            children: [
              Positioned(
                bottom: 7,
                right: 5,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.amber,
                          title: const Text('Delete Note'),
                          content: const Text(
                              'Are you sure you want to delete this note?'),
                          actions: [
                            FlatButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: const Text('Delete'),
                              onPressed: () {
                                BlocProvider.of<NoteBloc>(context)
                                    .add(NoteDeleteEvent(index: index));
                                Navigator.of(context).pop();
                                // delete the note
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  hoverColor: Colors.red,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        letterSpacing: 1,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: .5,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Text(
                      content,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          wordSpacing: 1.25,
                          letterSpacing: 1),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
