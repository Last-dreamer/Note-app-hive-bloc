// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_todo_bloc/database/note_database.dart';
import 'package:hive_todo_bloc/model/note_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteDatabase _noteDatabase;
  List<Note> _notes = [];

  NoteBloc(this._noteDatabase) : super(NoteInitial());

  @override
  Stream<NoteState> mapEventToState(
    NoteEvent event,
  ) async* {
    if (event is NoteInitialEvent) {
      yield* _mapNoteInitialEventToState();
    }

    if (event is NoteAddEvent) {
      yield* _mapNoteAddEventToState(event.note);
    }

    if (event is NoteEditEvent) {
      yield* _mapNoteEditEventToState(event.note, event.index);
    }

    if (event is NoteDeleteEvent) {
      yield* _mapNoteDeleteEventToState(event.index);
    }
  }

  Stream<NoteState> _mapNoteInitialEventToState() async* {
    yield NoteLoading();
    await getAllNotes();
    yield AllNotes(notes: _notes);
  }

  Stream<NoteState> _mapNoteAddEventToState(Note note) async* {
    yield NoteLoading();
    await _addNote(note);
    yield AllNotes(notes: _notes);
  }

  Stream<NoteState> _mapNoteEditEventToState(Note note, int index) async* {
    yield NoteLoading();
    await _editNote(note, index);
    yield AllNotes(notes: _notes);
  }

  Stream<NoteState> _mapNoteDeleteEventToState(int index) async* {
    yield NoteLoading();
    await _deleteNote(index);
    _notes.sort((a, b) {
      var aData = a.title;
      var bData = b.title;
      return aData!.compareTo(bData!);
    });

    yield AllNotes(notes: _notes);
  }

  getAllNotes() async {
    await _noteDatabase.getAllNotes().then((notes) {
      _notes = notes;
    });
  }

  _addNote(Note note) async {
    await _noteDatabase.addNote(note);
    await getAllNotes();
  }

  _editNote(Note note, int index) async {
    await _noteDatabase.updateNote(note, index);
    await getAllNotes();
  }

  _deleteNote(int index) async {
    await _noteDatabase.deleteNote(index);
    await getAllNotes();
  }
}
