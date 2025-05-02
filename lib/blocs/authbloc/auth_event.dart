part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthStateChanged extends AuthEvent {
  final User? user;
  const AuthStateChanged(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogoutRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}

class GoogleSignInRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}
