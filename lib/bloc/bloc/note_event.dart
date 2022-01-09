part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class NoteInitialEvent extends NoteEvent {}

class NoteAddEvent extends NoteEvent {
  final Note note;

  const NoteAddEvent({required this.note});

  @override
  List<Object> get props => [note];
}

class NoteEditEvent extends NoteEvent {
  final Note note;
  final int index;

  const NoteEditEvent({required this.note, required this.index});

  @override
  List<Object> get props => [note, index];
}

class NoteDeleteEvent extends NoteEvent {
  final int index;
  const NoteDeleteEvent({required this.index});
  @override
  List<Object> get props => [index];
}
