import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_todo_bloc/bloc/bloc/note_bloc.dart';
import 'package:hive_todo_bloc/model/note_model.dart';

class EditNoteScreen extends StatefulWidget {
  final bool? newNote;
  final Note? note;
  final int? index;
  const EditNoteScreen({Key? key, this.newNote, this.note, this.index})
      : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    final String _title =
        widget.newNote != null ? widget.note?.title ?? "" : "";

    final String _content =
        widget.newNote != null ? widget.note?.content ?? "" : "";

    final _formKey = GlobalKey<FormState>();
    TextEditingController? titleController =
        TextEditingController(text: _title);
    TextEditingController contentController =
        TextEditingController(text: _content);

    return Container(
        width: double.infinity,
        height: double.infinity,
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
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(widget.newNote == true ? 'New Note' : 'Edit Note'),
          ),
          body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      NoteTitle(titleController: titleController),
                      const SizedBox(
                        height: 20,
                      ),
                      NoteContent(contentController: contentController),
                    ],
                  ))),
          floatingActionButton: FloatingActionButton.extended(
            label: Row(
              children: [
                const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.newNote == true ? 'Save' : 'Update',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFFBB034),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.newNote == true
                    ? BlocProvider.of<NoteBloc>(context).add(NoteAddEvent(
                        note: Note(
                        title: titleController!.text,
                        content: contentController.text,
                      )))
                    : BlocProvider.of<NoteBloc>(context).add(NoteEditEvent(
                        note: Note(
                          title: titleController!.text,
                          content: contentController.text,
                        ),
                        index: widget.index!));

                Navigator.pop(context);
              }
            },
          ),
        ));
  }
}

class NoteTitle extends StatelessWidget {
  final TextEditingController? _titleController;
  const NoteTitle({TextEditingController? titleController})
      : _titleController = titleController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: _titleController,
        validator: (v) {
          return v!.isEmpty ? 'Title is required' : null;
        },
        decoration: InputDecoration(
          labelText: 'Title',
          labelStyle: const TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class NoteContent extends StatelessWidget {
  final TextEditingController? contentController;
  const NoteContent({Key? key, this.contentController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: contentController,
        maxLines: 15,
        validator: (content) {
          return content!.isEmpty ? 'Content cannot be empty.....' : null;
        },
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
