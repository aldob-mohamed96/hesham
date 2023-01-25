import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hesham/core/enum/enums.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/app_constant.dart';
import 'package:hesham/features/business_logic/bloc/auth/auth/authentication_bloc.dart';
import 'package:hesham/features/domain/entities/user.dart';
import 'package:hesham/features/domain/usecases/app_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:path/path.dart';

import '../../../../../core/input_form_validation/input_model.dart';
import '../../../../domain/entities/failure.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>   {
  final LoginUseCase _loginUseCase;


  LoginUseCaseInput loginUseCaseInput=LoginUseCaseInput(AppConstants.defaultEmptyString,AppConstants.defaultEmptyString,AppConstants.defaultEmptyString );

  LoginBloc({required LoginUseCase loginUseCase }) :
        _loginUseCase=loginUseCase,
        super(const LoginState()) {
    on<PasswordChanged>(_onPasswordChanged);
    on<UsernameChanged>(_onUsernameChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<VisiblePasswordChanged>(_onVisiblePasswordChanged);

  }
  void _onVisiblePasswordChanged(VisiblePasswordChanged event, Emitter<LoginState> emit,)
  {

    emit(state.copyWith(

      isVisible:!state.isVisible,
      password: state.password,
      username: state.username,
      status: Formz.validate([state.password,state.username]),
    ));

  }




  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit,) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password,state.username]),
      ),
    );
  }
  void _onUsernameChanged(UsernameChanged event, Emitter<LoginState> emit,) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([state.password,username]),
      ),
    );
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit,)async {

    if (state.status.isValidated)
    {

      emit(state.copyWith(status: FormzStatus.submissionInProgress));
     // final token=await getToken();

      final result=await _loginUseCase.execute(LoginUseCaseInput(state.username.value,state.password.value,"android"));
      result.fold(
              (failure) => emit(state.copyWith(status: FormzStatus.submissionFailure,failure: failure)),
              (success) {

                success.data?.blocked == 1 ?
                emit(state.copyWith(status: FormzStatus.submissionFailure,
                    failure: AppConstants.accountPendingFailure,)) :
                emit(state.copyWith(status: FormzStatus.submissionSuccess,user: success.data));
              }
              );


    }





  }

}
