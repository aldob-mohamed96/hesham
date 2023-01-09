import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';
@JsonSerializable()
class BaseResponse{
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "maintain")
  bool? maintain;
  @JsonKey(name: "errorId")
  String? errorId;
  
 }

