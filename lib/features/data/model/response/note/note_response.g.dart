// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteOrderResponse _$NoteOrderResponseFromJson(Map<String, dynamic> json) =>
    NoteOrderResponse(
      json['id'] as int?,
      json['title'] as String?,
      json['description'] as String?,
      json['created_at'] as String?,
    );

Map<String, dynamic> _$NoteOrderResponseToJson(NoteOrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'created_at': instance.createdAt,
    };

NoteOrdersDataResponse _$NoteOrdersDataResponseFromJson(
        Map<String, dynamic> json) =>
    NoteOrdersDataResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => NoteOrderResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['current_page'] as int?,
      json['from'] as int?,
      json['last_page'] as int?,
      json['to'] as int?,
      json['total'] as int?,
    );

Map<String, dynamic> _$NoteOrdersDataResponseToJson(
        NoteOrdersDataResponse instance) =>
    <String, dynamic>{
      'data': instance.noteOrderResponse,
      'current_page': instance.currentPage,
      'from': instance.from,
      'last_page': instance.lastPage,
      'to': instance.to,
      'total': instance.total,
    };

NoteOrdersPaginationResponse _$NoteOrdersPaginationResponseFromJson(
        Map<String, dynamic> json) =>
    NoteOrdersPaginationResponse(
      NoteOrdersDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..maintain = json['maintain'] as bool?
      ..errorId = json['errorId'] as String?;

Map<String, dynamic> _$NoteOrdersPaginationResponseToJson(
        NoteOrdersPaginationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
      'maintain': instance.maintain,
      'errorId': instance.errorId,
      'data': instance.noteOrdersDataResponse,
    };
