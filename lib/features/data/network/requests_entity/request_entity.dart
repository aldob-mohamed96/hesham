//param collected in class to pass function login not one one passing password ,username ,token ,....
//will pass loginRequest un one way only
import 'dart:io';

import 'package:hesham/core/di/dependency_injection.dart';
import 'package:hesham/core/enum/enums.dart';
import 'package:hesham/core/preferences/app_prefs.dart';
import 'package:hesham/core/resources/strings_manager.dart';

import '../../../../core/resources/app_constant.dart';



class LoginRequest {
  String phone;
  String password;
  String macAddress;
  LoginRequest(this.phone,this.password,this.macAddress);


  }
class LessonRequest {
  int id;

  LessonRequest(this.id);


}

class SheetRequest {
  int id;
  File file;
  SheetRequest(this.id,this.file);


}
class AddContactRequest {
  String  message;

  AddContactRequest(this.message);


}










