part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
}
class RefreshNote extends NoteEvent{
  @override
  List<Object?> get props => [];

}
class FetchingNote extends NoteEvent{
  @override
  List<Object?> get props => [];

}

