import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:hesham/features/business_logic/bloc/auth/auth/authentication_state.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/enum/enums.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/preferences/app_prefs.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/usecases/app_usecase.dart';

part 'authentication_event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>
{     final _controller = StreamController<AuthenticationStatus>();
      final AuthenticationUseCase authenticationsUseCase;
      late StreamSubscription<AuthenticationStatus>_authenticationStatusSubscription;
      User user=User.empty;
      AuthenticationBloc({required AuthenticationUseCase authenticationUseCase})
          : authenticationsUseCase=authenticationUseCase,

            super(const AuthenticationState.unknown())
            {

              on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
             _authenticationStatusSubscription = status.listen((status) => add(AuthenticationStatusChanged(status)),);

            }

      Future<void> _onAuthenticationStatusChanged(AuthenticationStatusChanged event, Emitter<AuthenticationState> emit)async
      {

        switch (event.status) {
          case AuthenticationStatus.authenticated:
            emit(const AuthenticationState.authenticated(Authentication.empty));
            break;
          case AuthenticationStatus.unknown:
          case AuthenticationStatus.unauthenticated:
          default:
             emit(const AuthenticationState.unauthenticated());
        }

      }
      Stream<AuthenticationStatus> get status async* {
        await Future<void>.delayed(Duration.zero);
        yield* _controller.stream;
      }
      Future<void> isLoggedIn()async
      {

        final result=await authenticationsUseCase.isLoggedIn();
        result.fold((l) {
          _controller.add(AuthenticationStatus.unauthenticated);
        }, (isLoggedIn) async {
          if(isLoggedIn)
          {
            final authUser=await authenticationsUseCase.execute(unit);
            authUser.fold((l) {
              bool isViewed=instance<AppSettingPreferences>().getAppOnBoardingIsViewed();
              _controller.add(isViewed?AuthenticationStatus.unauthenticated:AuthenticationStatus.firstTimeAppOpened);
            }, (r) {
                user=r.data!;
              _controller.add(AuthenticationStatus.authenticated);
            });

          }else
          {
            bool isViewed=instance<AppSettingPreferences>().getAppOnBoardingIsViewed();
            _controller.add(isViewed?AuthenticationStatus.unauthenticated:AuthenticationStatus.firstTimeAppOpened);
          }

        });
      }
      @override
      Future<void> close() {
        _authenticationStatusSubscription.cancel();
        _controller.close();
        return super.close();
      }
}
