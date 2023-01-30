part of 'home_bloc.dart';

class HomeState extends Equatable{
  final HomeData homeData;
  final List<String> images;
  final int selected;
  final Subject subject;
  final File? file;

  final StatePage statePage;
  final LessonData lessonData;
  final Failure failure;
  final bool isUploaded;
  final bool logout;
  final MessageData chatMessages;
  final bool isFirst;
  final bool hasReachedMax;
  final bool isRecording;
 const HomeState({
   this.chatMessages=const MessageData.empty(),
   this.images=const <String>[],
   this.file,
   this.selected=1,
   this.logout=false,
   this.isFirst=false,
   this.hasReachedMax=false,
   this.isUploaded=false,
   this.isRecording=false,
   this.subject=const Subject.empty(),
   this.lessonData=const LessonData.empty(),
   this.homeData=const HomeData.empty(),this.statePage=StatePage.initial,this.failure=const Failure.unknown()});
 HomeState copyWith({
   LessonData? lessonData,
   bool? open,
   MessageData? chatMessages,
   bool? logout,
   File? file,
   List<String>? images,
   bool? isUploaded,
   bool? hasReachedMax,
   bool? isFirst,
   bool? isRecording,
   int? selected,
   Subject? subject,
   HomeData? homeData,
   StatePage? statePage,
   Failure? failure,
 })=>HomeState(
     chatMessages: chatMessages??this.chatMessages,
     file: file??this.file,
     images: images??this.images,
     logout: logout??this.logout,
     isFirst: isFirst??this.isFirst,
     isRecording: isRecording??this.isRecording,
     hasReachedMax: hasReachedMax??this.hasReachedMax,
     subject: subject??this.subject,
     selected: selected??this.selected,
     isUploaded: isUploaded??this.isUploaded,
     lessonData: lessonData??this.lessonData,
     homeData: homeData??this.homeData,
     statePage: statePage??this.statePage,
     failure:failure??this.failure);

  @override
  List<Object?> get props => [homeData,isRecording,chatMessages,images,file,logout,isUploaded,subject,statePage,selected,lessonData,failure];

}
