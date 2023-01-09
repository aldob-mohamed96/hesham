// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['id'] as int?,
      json['name'] as String?,
      json['phone'] as String?,
      json['remember_token'] as String?,
      json['avatar'] as String?,
      json['username'] as String?,
      json['email'] as String?,
      json['type'] as String?,
      json['mac_address'] as String?,
      json['blocked'] as String?,
      json['bio'] as String?,
      json['power'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'remember_token': instance.rememberToken,
      'avatar': instance.avatar,
      'username': instance.username,
      'email': instance.email,
      'type': instance.type,
      'mac_address': instance.macAddress,
      'blocked': instance.blocked,
      'bio': instance.bio,
      'power': instance.power,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['data'] == null
          ? null
          : UserResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..maintain = json['maintain'] as bool?
      ..errorId = json['errorId'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'maintain': instance.maintain,
      'errorId': instance.errorId,
      'data': instance.user,
    };

LogoutResponse _$LogoutResponseFromJson(Map<String, dynamic> json) =>
    LogoutResponse(
      json['logout_time'] as String?,
    )
      ..status = json['status'] as int?
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..maintain = json['maintain'] as bool?
      ..errorId = json['errorId'] as String?;

Map<String, dynamic> _$LogoutResponseToJson(LogoutResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'maintain': instance.maintain,
      'errorId': instance.errorId,
      'logout_time': instance.logoutTime,
    };

LogoutAuthResponse _$LogoutAuthResponseFromJson(Map<String, dynamic> json) =>
    LogoutAuthResponse(
      json['data'] == null
          ? null
          : LogoutResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..maintain = json['maintain'] as bool?
      ..errorId = json['errorId'] as String?;

Map<String, dynamic> _$LogoutAuthResponseToJson(LogoutAuthResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'maintain': instance.maintain,
      'errorId': instance.errorId,
      'data': instance.data,
    };

DeletedAuthResponse _$DeletedAuthResponseFromJson(Map<String, dynamic> json) =>
    DeletedAuthResponse(
      json['data'] as bool?,
    )
      ..status = json['status'] as int?
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..maintain = json['maintain'] as bool?
      ..errorId = json['errorId'] as String?;

Map<String, dynamic> _$DeletedAuthResponseToJson(
        DeletedAuthResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'maintain': instance.maintain,
      'errorId': instance.errorId,
      'data': instance.data,
    };

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      json['id'] as int?,
      json['title'] as String?,
      json['description'] as String?,
    );

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };

HomeDataResponse _$HomeDataResponseFromJson(Map<String, dynamic> json) =>
    HomeDataResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => HomeResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..maintain = json['maintain'] as bool?
      ..errorId = json['errorId'] as String?;

Map<String, dynamic> _$HomeDataResponseToJson(HomeDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'maintain': instance.maintain,
      'errorId': instance.errorId,
      'data': instance.data,
    };

AttachmentResponse _$AttachmentResponseFromJson(Map<String, dynamic> json) =>
    AttachmentResponse(
      json['id'] as int?,
      json['lesson_id'] as String?,
      json['title'] as String?,
      json['file'] as String?,
      json['final_date_receive'] as String?,
    );

Map<String, dynamic> _$AttachmentResponseToJson(AttachmentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lesson_id': instance.lessonId,
      'title': instance.title,
      'file': instance.file,
      'final_date_receive': instance.finalDateReceive,
    };

LessonResponse _$LessonResponseFromJson(Map<String, dynamic> json) =>
    LessonResponse(
      json['id'] as int?,
      json['course_id'] as String?,
      json['title'] as String?,
      json['video'] as String?,
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonResponseToJson(LessonResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'title': instance.title,
      'video': instance.video,
      'attachments': instance.attachments,
    };

CoursesResponse _$CoursesResponseFromJson(Map<String, dynamic> json) =>
    CoursesResponse(
      json['id'] as int?,
      json['subject_id'] as String?,
      json['title'] as String?,
      json['description'] as String?,
      (json['lessons'] as List<dynamic>?)
          ?.map((e) => LessonResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoursesResponseToJson(CoursesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject_id': instance.subjectId,
      'title': instance.title,
      'description': instance.description,
      'lessons': instance.lessons,
    };

ImagesResponse _$ImagesResponseFromJson(Map<String, dynamic> json) =>
    ImagesResponse(
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ImagesResponseToJson(ImagesResponse instance) =>
    <String, dynamic>{
      'images': instance.images,
    };

SubjectResponse _$SubjectResponseFromJson(Map<String, dynamic> json) =>
    SubjectResponse(
      json['id'] as int?,
      json['state'] as String?,
      json['title'] as String?,
      json['description'] as String?,
      (json['courses'] as List<dynamic>?)
          ?.map((e) => CoursesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubjectResponseToJson(SubjectResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'title': instance.title,
      'description': instance.description,
      'courses': instance.courses,
    };

HomeContentResponse _$HomeContentResponseFromJson(Map<String, dynamic> json) =>
    HomeContentResponse(
      (json['subjects'] as List<dynamic>?)
          ?.map((e) => SubjectResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['images'] as List<dynamic>?,
    );

Map<String, dynamic> _$HomeContentResponseToJson(
        HomeContentResponse instance) =>
    <String, dynamic>{
      'subjects': instance.subjects,
      'images': instance.images,
    };

HomeSubjectResponse _$HomeSubjectResponseFromJson(Map<String, dynamic> json) =>
    HomeSubjectResponse(
      json['data'] == null
          ? null
          : HomeContentResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..maintain = json['maintain'] as bool?
      ..errorId = json['errorId'] as String?;

Map<String, dynamic> _$HomeSubjectResponseToJson(
        HomeSubjectResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'maintain': instance.maintain,
      'errorId': instance.errorId,
      'data': instance.data,
    };

SuccessOperationResponse _$SuccessOperationResponseFromJson(
        Map<String, dynamic> json) =>
    SuccessOperationResponse(
      json['data'] as String?,
    )
      ..status = json['status'] as int?
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..maintain = json['maintain'] as bool?
      ..errorId = json['errorId'] as String?;

Map<String, dynamic> _$SuccessOperationResponseToJson(
        SuccessOperationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'maintain': instance.maintain,
      'errorId': instance.errorId,
      'data': instance.data,
    };

ChatReplayResponse _$ChatReplayResponseFromJson(Map<String, dynamic> json) =>
    ChatReplayResponse(
      json['id'] as int?,
      json['content'] as String?,
      json['created_at'] as String?,
    );

Map<String, dynamic> _$ChatReplayResponseToJson(ChatReplayResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'created_at': instance.createdAt,
    };

ChatMessageResponse _$ChatMessageResponseFromJson(Map<String, dynamic> json) =>
    ChatMessageResponse(
      json['id'] as int?,
      json['message'] as String?,
      json['created_at'] as String?,
      (json['replies'] as List<dynamic>?)
          ?.map((e) => ChatReplayResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatMessageResponseToJson(
        ChatMessageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'created_at': instance.createdAt,
      'replies': instance.replies,
    };

MessageObjectResponse _$MessageObjectResponseFromJson(
        Map<String, dynamic> json) =>
    MessageObjectResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => ChatMessageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['current_page'] as int?,
      json['from'] as int?,
      json['last_page'] as int?,
      json['to'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$MessageObjectResponseToJson(
        MessageObjectResponse instance) =>
    <String, dynamic>{
      'data': instance.chatMessageResponse,
      'current_page': instance.currentPage,
      'from': instance.from,
      'last_page': instance.lastPage,
      'to': instance.to,
      'total': instance.total,
    };

ContactResponse _$ContactResponseFromJson(Map<String, dynamic> json) =>
    ContactResponse(
      MessageObjectResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..maintain = json['maintain'] as bool?
      ..errorId = json['errorId'] as String?;

Map<String, dynamic> _$ContactResponseToJson(ContactResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'maintain': instance.maintain,
      'errorId': instance.errorId,
      'data': instance.messageObjectResponse,
    };
