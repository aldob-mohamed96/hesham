part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged({required this.password});


  @override
  List<Object> get props => [password];
}
class UsernameChanged extends LoginEvent {
  final String username;
  const UsernameChanged({required this.username});


  @override
  List<Object> get props => [username];
}
class VisiblePasswordChanged extends LoginEvent {

  const VisiblePasswordChanged();


  @override
  List<Object> get props => [];
}
class LoginSubmitted extends LoginEvent {

  @override
  List<Object?> get props => [];
}
