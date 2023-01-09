

import 'package:hesham/features/domain/entities/chat.dart';
import 'package:hesham/features/domain/entities/courses.dart';
import 'package:hesham/features/domain/entities/logout.dart';
import 'package:hesham/features/domain/entities/note.dart';
import '../../data/network/requests_entity/request_entity.dart';
import '../entities/failure.dart';
import '../entities/user.dart';
import 'package:dartz/dartz.dart';
abstract class AuthRepository {

  Future<Either<Failure, Authentication>> checkAuthentication();
  Future<Either<Failure, HomeData>> getHome();
  Future<Either<Failure, LogoutData>> logout();
  Future<Either<Failure, SuccessData>> attendance(LessonRequest lessonRequest);
  Future<Either<Failure, SuccessData>> uploadSheet(SheetRequest sheetRequest);
  Future<Either<Failure, SuccessData>> addContact(AddContactRequest sheetRequest);
  Future<Either<Failure, MessageDataPagaination>> getContact(LessonRequest lessonRequest);
  Future<Either<Failure, NotePaginationOrders>> getNote(LessonRequest lessonRequest);
   Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Either<Failure, bool>  isUserLoggedIn();

}
