

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/resources/app_constant.dart';
import '../../../domain/entities/cash_item.dart';
import '../../../domain/entities/failure.dart';
import '../../../domain/entities/notification.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());
  void increaseNotification(int value)=>emit(state.copyWith(countNotification: state.countNotification+value));

  void showNotification(RemoteMessage remoteMessage)async{

       emit(state.copyWith(countNotification:state.countNotification+1));

  }
  void clearNotification()async{

    emit(state.copyWith(countNotification:0));

  }





}
