import 'package:equatable/equatable.dart';

import '../../../../../core/enum/enums.dart';
import '../../../../domain/entities/user.dart';



class AuthenticationState extends Equatable {
  final AuthenticationStatus authenticationStatus;
  final Authentication authentication;
  const AuthenticationState._({this.authenticationStatus=AuthenticationStatus.unknown,this.authentication=Authentication.empty});
  const AuthenticationState.authenticated(Authentication authenticationUser) :this._(authenticationStatus:AuthenticationStatus.authenticated,authentication: authenticationUser);
  const AuthenticationState.unauthenticated() :this._(authenticationStatus:AuthenticationStatus.unauthenticated);
  const AuthenticationState.unknown() :this._(authenticationStatus:AuthenticationStatus.unknown);

  @override
  List<Object?> get props =>[authenticationStatus,authentication];
}


