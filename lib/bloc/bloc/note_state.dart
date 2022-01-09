part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class EditNoteState extends NoteState {
  final Note note;

  const EditNoteState({required this.note});

  @override
  List<Object> get props => [note];
}

class AllNotes extends NoteState {
  final List<Note> notes;
  const AllNotes({required this.notes});

  @override
  List<Object> get props => [notes];
}

class NewNoteState extends NoteState {}
