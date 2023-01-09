
import 'package:hesham/core/resources/app_api_codes.dart';
import 'package:hesham/core/resources/app_api_messages.dart';
import 'package:hesham/core/resources/app_constant.dart';
import 'package:equatable/equatable.dart';

import '../../../core/resources/app_constant.dart';

class Failure extends Equatable {
  final int code;
  final String message;
  const Failure(this.code,this.message);
  const Failure.empty():this(AppConstants.defaultEmptyInteger,AppConstants.defaultEmptyString);
  const Failure.unknown():this(ResponseCode.unknownError,ResponseMessage.unknownError);

  @override

  List<Object?> get props => [code,message];

}
