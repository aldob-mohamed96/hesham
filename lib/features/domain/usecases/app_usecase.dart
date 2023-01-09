


import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:hesham/features/domain/entities/chat.dart';
import 'package:hesham/features/domain/entities/courses.dart';
import 'package:hesham/features/domain/entities/logout.dart';
import 'package:hesham/features/domain/entities/note.dart';

import '../../../core/enum/enums.dart';
import '../../data/network/requests_entity/request_entity.dart';

import '../entities/failure.dart';
import '../entities/user.dart';
import '../repositories/app_repository.dart';
import 'base_usecase.dart';
import 'package:dartz/dartz.dart';


class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final AuthRepository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.phone, input.password,input.macAddress));
  }



}class HomeUseCase implements BaseUseCase<Unit, HomeData> {
  final AuthRepository _repository;
  HomeUseCase(this._repository);
  @override
  Future<Either<Failure, HomeData>> execute(unit) async {
    return await _repository.getHome();
  }



}
class SheetUseCase implements BaseUseCase<SheetRequest, SuccessData> {
  final AuthRepository _repository;
  SheetUseCase(this._repository);
  @override
  Future<Either<Failure, SuccessData>> execute(SheetRequest sheetRequest) async {
    return await _repository.uploadSheet(sheetRequest);
  }
}
class AttendanceUseCase implements BaseUseCase<LessonRequest, SuccessData> {
  final AuthRepository _repository;
  AttendanceUseCase(this._repository);
  @override
  Future<Either<Failure, SuccessData>> execute(LessonRequest lessonRequest) async {
    return await _repository.attendance(lessonRequest);
  }
}class AddContactUseCase implements BaseUseCase<AddContactRequest, SuccessData> {
  final AuthRepository _repository;
  AddContactUseCase(this._repository);
  @override
  Future<Either<Failure, SuccessData>> execute(AddContactRequest addContactRequest) async {
    return await _repository.addContact(addContactRequest);
  }
}
class ContactUseCase implements BaseUseCase<LessonRequest, MessageDataPagaination> {
  final AuthRepository _repository;
  ContactUseCase(this._repository);
  @override
  Future<Either<Failure, MessageDataPagaination>> execute(LessonRequest lessonRequest) async {
    return await _repository.getContact(lessonRequest);
  }
}class NoteUseCase implements BaseUseCase<LessonRequest, NotePaginationOrders> {
  final AuthRepository _repository;
  NoteUseCase(this._repository);
  @override
  Future<Either<Failure, NotePaginationOrders>> execute(LessonRequest lessonRequest) async {
    return await _repository.getNote(lessonRequest);
  }
}
class LogoutUseCase implements BaseUseCase<Unit, LogoutData> {
  final AuthRepository _repository;
  LogoutUseCase(this._repository);
  @override
  Future<Either<Failure, LogoutData>> execute(unit) async {
    return await _repository.logout();
  }
}




class AuthenticationUseCase implements BaseUseCase<Unit,Authentication> {
  final AuthRepository _repository;

  AuthenticationUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(Unit unit) async {
    return await _repository.checkAuthentication();
  }

  Future<Either<Failure,bool>> isLoggedIn()async
  {
    return _repository.isUserLoggedIn();
  }



}






class LoginUseCaseInput {
  String phone;
  String password;
  String macAddress;
  LoginUseCaseInput(this.phone, this.password,this.macAddress);
}
class LogoutUsecaseInput{
  String token;
  LogoutUsecaseInput(this.token);
}
class CheckingPhoneIsRegisteredUseCaseInput {
  String username;
  CheckingPhoneIsRegisteredUseCaseInput({ required this.username});
}


