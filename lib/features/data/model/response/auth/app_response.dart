import 'package:json_annotation/json_annotation.dart';
import '../base/base_response.dart';

part 'app_response.g.dart';

@JsonSerializable()
class UserResponse{
  @JsonKey(name: "id")
   int? id;
  @JsonKey(name: "name")
   String? name;
  @JsonKey(name: "phone")
   String? phone;
  @JsonKey(name: "remember_token")
   String? rememberToken;
  @JsonKey(name: "avatar")
   String? avatar;
  @JsonKey(name: "username")
   String? username;
  @JsonKey(name: "email")
   String?  email ;
  @JsonKey(name: "type")
   String?  type ;
  @JsonKey(name: "mac_address")
   String?  macAddress ;
  @JsonKey(name: "blocked")
   String?  blocked ;
  @JsonKey(name: "bio")
   String?  bio ;
  @JsonKey(name: "power")
   String?  power ;


  UserResponse(
      this.id,
      this.name,
      this.phone,
      this.rememberToken,
      this.avatar,
      this.username,
      this.email ,
      this.type ,
      this.macAddress ,
      this.blocked ,
      this.bio ,
      this.power ,
     );
  //from json

  factory UserResponse.fromJson(Map<String,dynamic> json)=>_$UserResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$UserResponseToJson(this);
}

//auth response login/register
@JsonSerializable()
class  AuthenticationResponse extends BaseResponse{
  @JsonKey(name: "data")
  UserResponse? user;
  AuthenticationResponse(this.user);
  AuthenticationResponse.empty();
  //from json
  factory AuthenticationResponse.fromJson(Map<String,dynamic> json)=>_$AuthenticationResponseFromJson(json);
 //to json
  Map<String,dynamic> toJson()=>_$AuthenticationResponseToJson(this);
}
@JsonSerializable()
class LogoutResponse extends BaseResponse{
  @JsonKey(name: "logout_time")
  String? logoutTime;

  LogoutResponse(this.logoutTime);
  factory LogoutResponse.fromJson(Map<String,dynamic> json)=>_$LogoutResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$LogoutResponseToJson(this);


}
@JsonSerializable()
class LogoutAuthResponse extends BaseResponse{
  @JsonKey(name: "data")
  LogoutResponse? data;

  LogoutAuthResponse(this.data);
  factory LogoutAuthResponse.fromJson(Map<String,dynamic> json)=>_$LogoutAuthResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$LogoutAuthResponseToJson(this);


}
@JsonSerializable()
class DeletedAuthResponse extends BaseResponse{
  @JsonKey(name: "data")
  bool? data;

  DeletedAuthResponse(this.data);
  factory DeletedAuthResponse.fromJson(Map<String,dynamic> json)=>_$DeletedAuthResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$DeletedAuthResponseToJson(this);

}






@JsonSerializable()
class HomeResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;


  HomeResponse(
      this.id,
      this.title,
      this.description,);
  //from json

  factory HomeResponse.fromJson(Map<String,dynamic> json)=>_$HomeResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$HomeResponseToJson(this);
}

//auth response login/register
@JsonSerializable()
class  HomeDataResponse extends BaseResponse{
  @JsonKey(name: "data")
  List<HomeResponse>? data;
  HomeDataResponse(this.data);
  HomeDataResponse.empty();
  //from json
  factory HomeDataResponse.fromJson(Map<String,dynamic> json)=>_$HomeDataResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$HomeDataResponseToJson(this);
}
@JsonSerializable()
class AttachmentResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "lesson_id")
  String? lessonId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "file")
  String? file;
  @JsonKey(name: "final_date_receive")
  String? finalDateReceive;


  AttachmentResponse(
      this.id,
      this.lessonId,
      this.title,
      this.file,
      this.finalDateReceive,

      );
  //from json

  factory AttachmentResponse.fromJson(Map<String,dynamic> json)=>_$AttachmentResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$AttachmentResponseToJson(this);
}

@JsonSerializable()
class LessonResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "course_id")
  String? courseId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "video")
  String? video;
  @JsonKey(name: "attachments")
  List<AttachmentResponse>? attachments;


  LessonResponse(
      this.id,
      this.courseId,
      this.title,
      this.video,
      this.attachments,

      );
  //from json

  factory LessonResponse.fromJson(Map<String,dynamic> json)=>_$LessonResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$LessonResponseToJson(this);
}

@JsonSerializable()
class CoursesResponse{
  @JsonKey(name: "id")
   int? id;
  @JsonKey(name: "subject_id")
  String? subjectId;
  @JsonKey(name: "title")
   String? title;
  @JsonKey(name: "description")
   String? description;
  @JsonKey(name: "lessons")
   List<LessonResponse>? lessons;
  CoursesResponse(
      this.id,
      this.subjectId,
      this.title,
      this.description,
      this.lessons,

      );
  //from json

  factory CoursesResponse.fromJson(Map<String,dynamic> json)=>_$CoursesResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$CoursesResponseToJson(this);
}

@JsonSerializable()
class ImagesResponse{
  @JsonKey(name: "images")
   List<String>? images;
   ImagesResponse(

      this.images,

      );
  //from json

  factory ImagesResponse.fromJson(Map<String,dynamic> json)=>_$ImagesResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$ImagesResponseToJson(this);
}


@JsonSerializable()
class SubjectResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "state")
  String? state;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "courses")
  List<CoursesResponse>? courses;
  SubjectResponse(
      this.id,
      this.state,
      this.title,
      this.description,
      this.courses,

      );
  //from json

  factory SubjectResponse.fromJson(Map<String,dynamic> json)=>_$SubjectResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$SubjectResponseToJson(this);
}


@JsonSerializable()
class  HomeContentResponse {
  @JsonKey(name: "subjects")
  List<SubjectResponse>? subjects;
  @JsonKey(name: "images")
  List<dynamic>? images;

  HomeContentResponse(this.subjects,this.images);
  //from json
  factory HomeContentResponse.fromJson(Map<String,dynamic> json)=>_$HomeContentResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$HomeContentResponseToJson(this);
}
@JsonSerializable()
class  HomeSubjectResponse extends BaseResponse{
  @JsonKey(name: "data")
  HomeContentResponse? data;
  HomeSubjectResponse(this.data);
  //from json
  factory HomeSubjectResponse.fromJson(Map<String,dynamic> json)=>_$HomeSubjectResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$HomeSubjectResponseToJson(this);
}


@JsonSerializable()
class SuccessOperationResponse extends BaseResponse{
  @JsonKey(name: "data")
  String? data;
  SuccessOperationResponse(this.data);
  SuccessOperationResponse.empty();
  //from json
  factory SuccessOperationResponse.fromJson(Map<String,dynamic> json)=>_$SuccessOperationResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$SuccessOperationResponseToJson(this);
}

@JsonSerializable()
class ChatReplayResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "content")
  String? content;
  @JsonKey(name: "created_at")
  String? createdAt;


  ChatReplayResponse(
      this.id,
      this.content,
      this.createdAt,);
  //from json

  factory ChatReplayResponse.fromJson(Map<String,dynamic> json)=>_$ChatReplayResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$ChatReplayResponseToJson(this);
}

@JsonSerializable()
class ChatMessageResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "replies")
  List<ChatReplayResponse>? replies;


  ChatMessageResponse(
      this.id,
      this.message,
      this.createdAt,
      this.replies
      );
  //from json

  factory ChatMessageResponse.fromJson(Map<String,dynamic> json)=>_$ChatMessageResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$ChatMessageResponseToJson(this);
}

@JsonSerializable()
class  MessageObjectResponse {
  @JsonKey(name: "data")
  List<ChatMessageResponse>? chatMessageResponse;
  @JsonKey(name: "current_page")
  int? currentPage;
  @JsonKey(name: "from")
  int? from;
  @JsonKey(name: "last_page")
  int? lastPage;
  @JsonKey(name: "to")
  int? to;
  @JsonKey(name: "total")
  int? total;
  MessageObjectResponse(this.chatMessageResponse,this.currentPage,this.from,this.lastPage,this.to,this.total,);

  //from json
  factory MessageObjectResponse.fromJson(Map<String,dynamic> json)=>_$MessageObjectResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$MessageObjectResponseToJson(this);
}
@JsonSerializable()
class  ContactResponse extends BaseResponse{
  @JsonKey(name: "data")
  MessageObjectResponse messageObjectResponse;
  ContactResponse(this.messageObjectResponse);

  //from json
  factory ContactResponse.fromJson(Map<String,dynamic> json)=>_$ContactResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$ContactResponseToJson(this);
}

