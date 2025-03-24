import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/auth_event.dart';
import '../services/auth_service.dart';
import '../states/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authService}) : super(const AuthState.initial()) {
    on<AuthEmailInputed>(_onAuthEmailInputed);
    on<AuthPasswordInputed>(_onAuthPasswordInputed);
    on<AuthSubmitted>(_onAuthSubmitted);
  }
  final AuthService authService;

  FutureOr<void> _onAuthEmailInputed(
      AuthEmailInputed event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      userPassport: state.userPassport.copyWith(email: event.email),
      status: AuthStatus.typing,
    ));
  }

  FutureOr<void> _onAuthPasswordInputed(
      AuthPasswordInputed event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      userPassport: state.userPassport.copyWith(password: event.password),
      status: AuthStatus.typing,
    ));
  }

  FutureOr<void> _onAuthSubmitted(
      AuthSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.submitting));

    final authState =
        await authService.signInWithEmailPassword(state.userPassport);

    emit(authState);
  }
}
