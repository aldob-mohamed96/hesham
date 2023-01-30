part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}
class GetHomeData extends HomeEvent{
  @override
  List<Object?> get props => [];

}
class ShowDataCourse extends HomeEvent{
  final Courses courses;

 const ShowDataCourse(this.courses);
  @override
  List<Object?> get props => [courses];

}class PickFile extends HomeEvent{

 const PickFile();
  @override
  List<Object?> get props => [];

}
class SelectedSubject extends HomeEvent{
  final int id;
  final Subject subject;

  const SelectedSubject(this.id,this.subject);
  @override
  List<Object?> get props => [id,subject];

}
class AttendanceLessonEvent extends HomeEvent{
  final Lesson lesson;

  const AttendanceLessonEvent(this.lesson);
  @override
  List<Object?> get props => [lesson];

}
class LogoutEvent extends HomeEvent{

  const LogoutEvent();
  @override
  List<Object?> get props => [];

}class RecordingEvent extends HomeEvent{
  final bool isRecord;
  const RecordingEvent(this.isRecord);
  @override
  List<Object?> get props => [isRecord];

}
class SheetLessonEvent extends HomeEvent{
  final File file;
  final Lesson lesson;
  const SheetLessonEvent(this.lesson,this.file);
  @override
  List<Object?> get props => [lesson,file];

}

class MessgesEvent extends HomeEvent{
  const MessgesEvent();
  @override
  List<Object?> get props => [];

}
class SendMessgesEvent extends HomeEvent{
  final String message;
  const SendMessgesEvent(this.message);
  @override
  List<Object?> get props => [message];

}