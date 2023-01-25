

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hesham/core/preferences/app_prefs.dart';
import 'package:hesham/core/services/network_info.dart';
import 'package:hesham/features/data/data_source/local/app_local.dart';
import 'package:hesham/features/data/model/mapper/app_response.dart';
import 'package:hesham/features/domain/entities/chat.dart';
import 'package:hesham/features/domain/entities/courses.dart';
import 'package:hesham/features/domain/entities/logout.dart';
import 'package:hesham/features/domain/entities/note.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/extension/extension.dart';


import '../../../core/enum/enums.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/resources/app_api_codes.dart';
import '../../../core/resources/app_api_messages.dart';
import '../../../core/resources/app_constant.dart';
import '../../domain/entities/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/app_repository.dart';
import '../data_source/remote/app_remote.dart';
import '../network/requests_entity/request_entity.dart';
import 'package:dartz/dartz.dart';
class AuthRepositoryImpl implements AuthRepository {

  final NetworkInfo _networkInfo;
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;


  AuthRepositoryImpl(this._remoteDataSource,this._authLocalDataSource,this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatusCode.success) {

          final data=response.toDomain();
          if(data.data?.blocked=="0")
          {
            await _authLocalDataSource.cashUserAuthentication(response);
          }
          return Right(data);
        }
        else if (response.status == ApiInternalStatusCode.maintain)
        {
          return const Left(AppConstants.maintainFailure);
        }
        else if (response.status == ApiInternalStatusCode.unAuthenticated)
        {
          await _authLocalDataSource.logout();
          return const Left(AppConstants.unAuthenticatedFailure);
        }
        else if (response.status == ApiInternalStatusCode.failure)
        {
          return Left(ErrorMessage.getErrorAuth(response.errorId.toString()).failure);
        }
        else
        {
          return const Left( AppConstants.unknownFailure);
        }
      } catch (error)
      {
        if(error is DioError)
        {
          if(error.response?.statusCode==401)
          {
            await _authLocalDataSource.logout();
            return const Left(AppConstants.unAuthenticatedFailure);
          }
        }
        return Left(NetworkException.handleNetworkError(error).failure);
      }
    } else {
      return Left(DataSourceNetworkError.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> checkAuthentication()async {
         try {
               final response = await _authLocalDataSource.authentication();
               return Right(response.toDomain());
           }
       catch(error)
          {
            if(error is DioError)
            {
              if(error.response?.statusCode==401)
              {
                await _authLocalDataSource.logout();
                return const Left(AppConstants.unAuthenticatedFailure);
              }
            }
                return Left(CashedException.handleCashedError(error).failure);
          }
     }
  @override
  Either<Failure, bool> isUserLoggedIn() {
    try{
      final result =_authLocalDataSource.isUserLoggedIn();
      return Right(result);
    }
    catch(error)
    {

      return Left(CashedException.handleCashedError(error).failure);
    }
  }

  @override
  Future<Either<Failure, HomeData>> getHome() async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getHome();
        if (response.status == ApiInternalStatusCode.success) {

          return Right(response.toDomain());
        }
        else if (response.status == ApiInternalStatusCode.maintain)
        {
          return const Left(AppConstants.maintainFailure);
        }
        else if (response.status == ApiInternalStatusCode.unAuthenticated)
        {
          await _authLocalDataSource.logout();
          return const Left(AppConstants.unAuthenticatedFailure);
        }
        else if (response.status == ApiInternalStatusCode.failure)
        {
          return Left(ErrorMessage.getErrorAuth(response.errorId.toString()).failure);
        }
        else
        {
          return const Left( AppConstants.unknownFailure);
        }
      } catch (error)
      {
        if(error is DioError)
          {
            if(error.response?.statusCode==401)
            {
              await _authLocalDataSource.logout();
              return const Left(AppConstants.unAuthenticatedFailure);
            }
          }
        return Left(NetworkException.handleNetworkError(error).failure);
      }
    } else {
      return Left(DataSourceNetworkError.noInternetConnection.getFailure());
    }
  }
 @override
  Future<Either<Failure, LogoutData>> logout() async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.logout();
        if (response.status == ApiInternalStatusCode.success)
        {
          _authLocalDataSource.logout();
          if(response.maintain==true)
        {
          return const Left(AppConstants.maintainFailure);
        }
        else
        {

          return Right(response.toDomain());
        }

        }
        else
        {
          return const Left( AppConstants.unknownFailure);
        }
      } catch (error)
      {
        if(error is DioError)
        {
          if(error.response?.statusCode==401)
          {
            await _authLocalDataSource.logout();
            return const Left(AppConstants.unAuthenticatedFailure);
          }
        }
        return Left(NetworkException.handleNetworkError(error).failure);
      }
    } else {
      return Left(DataSourceNetworkError.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, SuccessData>> attendance(LessonRequest lessonRequest) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.attendance(lessonRequest);
        if (response.status == ApiInternalStatusCode.success)
        {
            return Right(response.toDomain());
        }
        else if (response.status == ApiInternalStatusCode.maintain)
        {
          return const Left(AppConstants.maintainFailure);
        }
        else if (response.status == ApiInternalStatusCode.unAuthenticated)
        {
          await _authLocalDataSource.logout();
          return const Left(AppConstants.unAuthenticatedFailure);
        }
        else if (response.status == ApiInternalStatusCode.failure)
        {
          return Left(ErrorMessage.getErrorAuth(response.errorId.toString()).failure);
        }
        else
        {
          return const Left( AppConstants.unknownFailure);
        }
      } catch (error)
      {
        if(error is DioError)
        {
          if(error.response?.statusCode==401)
          {
            await _authLocalDataSource.logout();
            return const Left(AppConstants.unAuthenticatedFailure);
          }
        }
        return Left(NetworkException.handleNetworkError(error).failure);
      }
    } else {
      return Left(DataSourceNetworkError.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, SuccessData>> uploadSheet(SheetRequest sheetRequest)async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.sheet(sheetRequest);
        if (response.status == ApiInternalStatusCode.success)
        {
            return Right(response.toDomain());
        }
        else if (response.status == ApiInternalStatusCode.maintain)
        {
          return const Left(AppConstants.maintainFailure);
        }
        else if (response.status == ApiInternalStatusCode.unAuthenticated)
        {
          await _authLocalDataSource.logout();
          return const Left(AppConstants.unAuthenticatedFailure);
        }
        else if (response.status == ApiInternalStatusCode.failure)
        {
          return Left(ErrorMessage.getErrorAuth(response.errorId.toString()).failure);
        }
        else
        {
          return const Left( AppConstants.unknownFailure);
        }
      } catch (error)
      {
        if(error is DioError)
        {
          if(error.response?.statusCode==401)
          {
            await _authLocalDataSource.logout();
            return const Left(AppConstants.unAuthenticatedFailure);
          }
        }

        return Left(NetworkException.handleNetworkError(error).failure);
      }
    } else {
      return Left(DataSourceNetworkError.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, SuccessData>> addContact(AddContactRequest sheetRequest) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.addContact(sheetRequest);
        if (response.status == ApiInternalStatusCode.success)
        {
            return Right(response.toDomain());
        }
        else if (response.status == ApiInternalStatusCode.maintain)
        {
          return const Left(AppConstants.maintainFailure);
        }
        else if (response.status == ApiInternalStatusCode.unAuthenticated)
        {
          await _authLocalDataSource.logout();
          return const Left(AppConstants.unAuthenticatedFailure);
        }
        else if (response.status == ApiInternalStatusCode.failure)
        {
          return Left(ErrorMessage.getErrorAuth(response.errorId.toString()).failure);
        }
        else
        {
          return const Left( AppConstants.unknownFailure);
        }
      } catch (error)
      {
        if(error is DioError)
        {
          if(error.response?.statusCode==401)
          {
            await _authLocalDataSource.logout();
            return const Left(AppConstants.unAuthenticatedFailure);
          }
        }
        return Left(NetworkException.handleNetworkError(error).failure);
      }
    } else {
      return Left(DataSourceNetworkError.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, MessageDataPagaination>> getContact(LessonRequest lessonRequest) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.contacts(lessonRequest);
        if (response.status == ApiInternalStatusCode.success)
        {
            return Right(response.toDomain());
        }
        else if (response.status == ApiInternalStatusCode.maintain)
        {
          return const Left(AppConstants.maintainFailure);
        }
        else if (response.status == ApiInternalStatusCode.unAuthenticated)
        {
          await _authLocalDataSource.logout();
          return const Left(AppConstants.unAuthenticatedFailure);
        }
        else if (response.status == ApiInternalStatusCode.failure)
        {
          return Left(ErrorMessage.getErrorAuth(response.errorId.toString()).failure);
        }
        else
        {
          return const Left( AppConstants.unknownFailure);
        }
      } catch (error)
      {
        if(error is DioError)
        {
          if(error.response?.statusCode==401)
          {
            await _authLocalDataSource.logout();
            return const Left(AppConstants.unAuthenticatedFailure);
          }
        }
        return Left(NetworkException.handleNetworkError(error).failure);
      }
    } else {
      return Left(DataSourceNetworkError.noInternetConnection.getFailure());
    }
  }
 @override
  Future<Either<Failure, NotePaginationOrders>> getNote(LessonRequest lessonRequest) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getNote(lessonRequest);
        if (response.status == ApiInternalStatusCode.success)
        {
            return Right(response.toDomain());
        }
        else if (response.status == ApiInternalStatusCode.maintain)
        {
          return const Left(AppConstants.maintainFailure);
        }
        else if (response.status == ApiInternalStatusCode.unAuthenticated)
        {
          await _authLocalDataSource.logout();
          return const Left(AppConstants.unAuthenticatedFailure);
        }
        else if (response.status == ApiInternalStatusCode.failure)
        {
          return Left(ErrorMessage.getErrorAuth(response.errorId.toString()).failure);
        }
        else
        {
          return const Left( AppConstants.unknownFailure);
        }
      } catch (error)
      {
        if(error is DioError)
        {
          if(error.response?.statusCode==401)
          {
            await _authLocalDataSource.logout();
            return const Left(AppConstants.unAuthenticatedFailure);
          }
        }
        return Left(NetworkException.handleNetworkError(error).failure);
      }
    } else {
      return Left(DataSourceNetworkError.noInternetConnection.getFailure());
    }
  }






}
