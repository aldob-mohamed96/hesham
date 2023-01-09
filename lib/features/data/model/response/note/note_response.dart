import 'package:json_annotation/json_annotation.dart';
import '../base/base_response.dart';

part 'note_response.g.dart';


@JsonSerializable()
class  NoteOrderResponse{
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "created_at")
  String? createdAt;
  NoteOrderResponse(
      this.id,
      this.title,
      this.description,
      this.createdAt,
      );
  //from json
  factory NoteOrderResponse.fromJson(Map<String,dynamic> json)=>_$NoteOrderResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$NoteOrderResponseToJson(this);
}
@JsonSerializable()
class  NoteOrdersDataResponse {
  @JsonKey(name: "data")
  List<NoteOrderResponse>? noteOrderResponse;
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
  NoteOrdersDataResponse(this.noteOrderResponse,this.currentPage,this.from,this.lastPage,this.to,this.total,);

  //from json
  factory NoteOrdersDataResponse.fromJson(Map<String,dynamic> json)=>_$NoteOrdersDataResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$NoteOrdersDataResponseToJson(this);
}

@JsonSerializable()
class  NoteOrdersPaginationResponse extends BaseResponse{
  @JsonKey(name: "data")
  NoteOrdersDataResponse noteOrdersDataResponse;
  NoteOrdersPaginationResponse(this.noteOrdersDataResponse);

  //from json
  factory NoteOrdersPaginationResponse.fromJson(Map<String,dynamic> json)=>_$NoteOrdersPaginationResponseFromJson(json);
  //to json
  Map<String,dynamic> toJson()=>_$NoteOrdersPaginationResponseToJson(this);
}
