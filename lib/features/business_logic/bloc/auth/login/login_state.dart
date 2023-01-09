part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzStatus status;
  final Password password;
  final Username username;
  final Failure failure;
  final bool isVisible;
  final User user;
  const LoginState({
    this.user=User.empty,
    this.status = FormzStatus.pure,
    this.password =const Password.pure(),
    this.username =const Username.pure(),
    this.failure=const Failure.empty(),
    this.isVisible=true

  });
  LoginState copyWith({
    FormzStatus? status,
    Password? password,
    Username? username,
    bool? isVisible,
    User? user,
    Failure? failure,
  }) {
    return LoginState(
        status: status ?? this.status,
        password: password ?? this.password,
        user:user??this.user,
        username: username ?? this.username,
        isVisible: isVisible??this.isVisible,
        failure: failure??this.failure

    );
  }

  @override
  List<Object> get props => [status,password,username,isVisible,user,failure];
}