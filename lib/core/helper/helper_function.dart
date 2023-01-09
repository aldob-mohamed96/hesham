
import 'package:hesham/core/error/error_handler.dart';

import '../../core/extension/extension.dart';
import '../../features/domain/entities/failure.dart';
import '../enum/enums.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'dart:convert' ;
import 'dart:io' as io;
abstract class HelperFunction{

  Future<Either<Unit,Map<String,String>>> getJsonFile(String path);
}
class HelperFunctionImpl implements HelperFunction  {

  @override
   Future<Either<Unit,Map<String,String>>> getJsonFile(String path) async {
    try {
      final fileContent=await _loadJsonFile(path);
      final map=_convertToMap(fileContent);

      return Right(map);
       }
    catch(error)
    {
      return const Left(unit);
    }
  }
  Map<String,String> _convertToMap(String content){
    Map<String,dynamic> jsonMap=json.decode(content);
    return jsonMap.map<String,String>((key, value) => MapEntry(key, value.toString()));

  }


  Future<String> _loadJsonFile(String path)async{
    return await rootBundle.loadString(path);
  }

}
