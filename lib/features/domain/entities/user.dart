

import 'package:equatable/equatable.dart';

import '../../../core/resources/app_constant.dart';

class User extends Equatable{
   final int id;
   final String name;
   final String phone;
   final String rememberToken;
   final String avatar;
   final String username;
   final String  email ;
   final String  type ;
   final String  macAddress ;
   final String  blocked ;
   final String  bio ;
   final String  power ;



   const User(
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
  static const empty= User(

      AppConstants.defaultEmptyInteger,
      AppConstants.defaultEmptyString,
      AppConstants.defaultEmptyString,
      AppConstants.defaultEmptyString,
      AppConstants.defaultEmptyString,
      AppConstants.defaultEmptyString,
      AppConstants.defaultEmptyString,
      AppConstants.defaultEmptyString,
      AppConstants.defaultEmptyString,
      AppConstants.defaultEmptyString,
      AppConstants.defaultEmptyString,
      AppConstants.defaultEmptyString,



  );
  bool get userIsEmpty=>this==empty;
  bool get userIsNotEmpty=>this!=empty;
  @override
  List<Object?> get props => [
     id,
     name,
     phone,
     rememberToken,
     avatar,
     username,
     email ,
     type ,
     macAddress ,
     blocked ,
     bio ,
     power ,
    ];}
  class Authentication extends Equatable{
  final User? data;
  const Authentication({required this.data});
  static const empty=Authentication(data: User.empty);
  bool get authenticated=>this!=empty;
  bool get unauthenticated=>this==empty;

  @override

  List<Object?> get props => [data];




}
