
import 'package:hesham/core/resources/app_constant.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/features/domain/entities/courses.dart';
import 'package:hesham/features/domain/entities/logout.dart';
import 'package:hesham/features/domain/entities/note.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/entities/user.dart';
import '../response/auth/app_response.dart';
import '../response/note/note_response.dart';



extension UserResponseMapper on UserResponse? {
  User toDomain() {
    return User(

      this?.id.orZeroInt() ?? AppConstants.defaultEmptyInteger,
      this?.name.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.phone.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.rememberToken.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.avatar.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.username.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.email.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.type.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.macAddress.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.blocked.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.bio.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.power.orEmpty() ?? AppConstants.defaultEmptyString,



    );
  }

}
extension HomeResponseMapper on HomeContentResponse? {
  HomeContent toDomain() {
    List<Subject> subject=(this?.subjects?.
    map((driverOrderResponse) => driverOrderResponse.toDomain())?? const Iterable.empty()).cast<Subject>().toList();
    List<String> images=(this?.images?.
    map((driverOrderResponse) => driverOrderResponse)?? const Iterable.empty()).cast<String>().toList();

    return HomeContent(
      subject,
      images




    );
  }

}
extension ImagesMapper on ImagesResponse? {
  Images toDomain() {
    List<String> images=(this?.images?.
    map((driverOrderResponse) => driverOrderResponse)?? const Iterable.empty()).cast<String>().toList();

    return Images(

      images,




    );
  }

}

extension HomeResponsesMapper on HomeSubjectResponse? {
  HomeData toDomain() {

    return HomeData(
      this?.data?.toDomain()??const HomeContent.empty(),
    );
  }

}
extension SuccessResponseMapper on SuccessOperationResponse? {
  SuccessData toDomain() {

    return SuccessData(this?.data.orEmpty()??AppConstants.defaultEmptyString,);}

}
extension AttchamentResponseMapper on AttachmentResponse? {
  Attachments toDomain() {
    return Attachments(

      this?.id.orZeroInt() ?? AppConstants.defaultEmptyInteger,
      this?.lessonId.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.title.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.file.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.finalDateReceive.orEmpty() ?? AppConstants.defaultEmptyString,



    );
  }

}
extension LessonsResponseMapper on LessonResponse? {
  Lesson toDomain() {

    List<Attachments> attachments=(this?.attachments?.
    map((attachments) => attachments.toDomain())?? const Iterable.empty()).cast<Attachments>().toList();
    return Lesson(

      this?.id.orZeroInt() ?? AppConstants.defaultEmptyInteger,
      this?.courseId.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.title.orEmpty() ?? AppConstants.defaultEmptyString,
      this?.video.orEmpty() ?? AppConstants.defaultEmptyString,
      attachments,



    );
  }

}
extension LessonDataResponseMapper on CoursesResponse? {

  Courses toDomain() {

    List<Lesson> lesson=(this?.lessons?.
    map((driverOrderResponse) => driverOrderResponse.toDomain())?? const Iterable.empty()).cast<Lesson>().toList();
    return Courses(

        this?.id.orZeroInt() ?? AppConstants.defaultEmptyInteger,
        this?.subjectId.orEmpty() ?? AppConstants.defaultEmptyString,
        this?.title.orEmpty() ?? AppConstants.defaultEmptyString,
        this?.description.orEmpty() ?? AppConstants.defaultEmptyString,
        lesson
    );
  }
}
extension HomeDataResponseMapper on SubjectResponse? {

  Subject toDomain() {

    List<Courses> cour=(this?.courses?.
    map((driverOrderResponse) => driverOrderResponse.toDomain())?? const Iterable.empty()).cast<Courses>().toList();
    return Subject(

        this?.id.orZeroInt() ?? AppConstants.defaultEmptyInteger,
        this?.title.orEmpty() ?? AppConstants.defaultEmptyString,
        this?.description.orEmpty() ?? AppConstants.defaultEmptyString,
        this?.state.orEmpty() ?? AppConstants.defaultEmptyString,
        cour
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      data:this?.user.toDomain(),
    );
  }
}
extension LogoutResponsAuthMapper on LogoutResponse?{
  Logout toDomain()
  {
    return Logout(this?.logoutTime.orEmpty()??AppConstants.defaultEmptyString);
  }
}
extension LogoutResponseAuthMapper on LogoutAuthResponse?{
  LogoutData toDomain()
  {
    return LogoutData(this?.data.toDomain()??const Logout.empty());
  }
}
extension DeletedResponseAuthMapper on DeletedAuthResponse?{
  DeletedAccount toDomain()
  {
    return DeletedAccount(this?.data.orBoolInit()??AppConstants.defaultEmptyBool);
  }
}


extension ChatReplayResponseAuthMapper on ChatReplayResponse?{
  ReplyMessagesChat toDomain()
  {
    return ReplyMessagesChat(
         this?.id.orZeroInt()??AppConstants.defaultEmptyInteger,
         this?.content.orEmpty()??AppConstants.defaultEmptyString,
         this?.createdAt.orEmpty()??AppConstants.defaultEmptyString,


       );
  }
}
extension ChatMessageResponseAuthMapper on ChatMessageResponse?{
  MessagesChat toDomain()
  {


    List<ReplyMessagesChat> rep=(this?.replies?.
    map((attachments) => attachments.toDomain())?? const Iterable.empty()).cast<ReplyMessagesChat>().toList();
    return MessagesChat(
      this?.id.orZeroInt()??AppConstants.defaultEmptyInteger,
      this?.message.orEmpty()??AppConstants.defaultEmptyString,
      rep,
      this?.createdAt.orEmpty()??AppConstants.defaultEmptyString,


    );
  }
}
extension MessageObjectResponseMapper on MessageObjectResponse?{
  MessageData toDomain()
  {


    List<MessagesChat> messagesChat=(this?.chatMessageResponse?.
    map((attachments) => attachments.toDomain())?? const Iterable.empty()).cast<MessagesChat>().toList();
    return MessageData(
      messagesChat,
      this?.currentPage.orZeroInt()??AppConstants.defaultEmptyInteger,
      this?.from.orZeroInt()??AppConstants.defaultEmptyInteger,
      this?.lastPage.orZeroInt()??AppConstants.defaultEmptyInteger,
      this?.to.orZeroInt()??AppConstants.defaultEmptyInteger,
      this?.total.orZeroInt()??AppConstants.defaultEmptyInteger,


    );
  }
}

extension MessagePaginationResponseMapper on ContactResponse?{
  MessageDataPagaination toDomain() {
    return MessageDataPagaination(
      this?.messageObjectResponse?.toDomain() ?? const MessageData.empty(),

    );
  }}

 extension NoteMapper on NoteOrderResponse?{
   NoteOrder toDomain()
   {
     return NoteOrder(
       this?.id.orZeroInt()??AppConstants.defaultEmptyInteger,
       this?.title.orEmpty()??AppConstants.defaultEmptyString,
       this?.description.orEmpty()??AppConstants.defaultEmptyString,
       this?.createdAt.orEmpty()??AppConstants.defaultEmptyString,


     );
   }
 }
 extension DriverOrdersDataExtension on NoteOrdersDataResponse?
 {
   NoteOrdersData toDomain()
   {
     List<NoteOrder> notes=(this?.noteOrderResponse?.
     map((driverOrderResponse) => driverOrderResponse.toDomain())?? const Iterable.empty()).cast<NoteOrder>().toList();

     return NoteOrdersData(
       notes,
       this?.currentPage.orZeroInt()??AppConstants.defaultEmptyInteger,
       this?.from.orZeroInt()??AppConstants.defaultEmptyInteger,
       this?.lastPage.orZeroInt()??AppConstants.defaultEmptyInteger,
       this?.to.orZeroInt()??AppConstants.defaultEmptyInteger,
       this?.total.orZeroInt()??AppConstants.defaultEmptyInteger,

     );
   }
 }
 extension NotePaginationResponseMapper on NoteOrdersPaginationResponse?{
   NotePaginationOrders toDomain() {
     return NotePaginationOrders(
       this?.noteOrdersDataResponse?.toDomain() ?? const NoteOrdersData.empty(),

     );
   }}