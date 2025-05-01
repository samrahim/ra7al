import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ra7al/repositories/authrepository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late StreamSubscription<User?> _userSubscription;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthStateChanged>(_onAuthStateChanged);
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);

    _userSubscription = authRepository.user.listen((user) {
      add(AuthStateChanged(user));
    });
  }

  void _onAuthStateChanged(AuthStateChanged event, Emitter<AuthState> emit) {
    emit(event.user != null ? Authenticated(event.user!) : Unauthenticated());
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.login(event.email, event.password);
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.logout();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
