part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final int countNotification;
  final NotificationData notificationData;
  final BodyNotification bodyNotification;

  final Failure failure;
  final bool isLoading;
  final bool newNote;

  final bool isFailure;


 const NotificationState({
   this.countNotification=0,
   this.bodyNotification=const BodyNotification.empty(),
   this.notificationData=const NotificationData.empty(),
   this.failure=const Failure.empty(),
   this.isLoading=false,
   this.newNote=false,
   this.isFailure=false,
 });


  NotificationState copyWith({
    int? countNotification,
     NotificationData? notificationData,
    BodyNotification? bodyNotification,
     Failure? failure,
     bool? isLoading,
     bool? newNote,
     bool? isFailure,

  }) {
    return NotificationState(countNotification: countNotification??this.countNotification,
       notificationData:notificationData??this.notificationData,
      bodyNotification:bodyNotification??this.bodyNotification,
      failure:failure??this.failure,
      isLoading:isLoading??this.isLoading,
      newNote:newNote??this.newNote,
      isFailure:isFailure??this.isFailure,


    );
  }


  @override
  List<Object?> get props => [
    countNotification,failure,isLoading,newNote,isFailure,notificationData,bodyNotification
  ];}

class BodyNotification extends Equatable{
  final int id;
  final String body ;
  final String title;
 const BodyNotification(this.id,this.body,this.title);
 const BodyNotification.empty():this(AppConstants.defaultEmptyInteger,AppConstants.defaultEmptyString,AppConstants.defaultEmptyString);
  @override


  List<Object?> get props =>[id,body,title] ;

}
