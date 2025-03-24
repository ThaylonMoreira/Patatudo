import 'package:equatable/equatable.dart';

import '../../../../shared/extensions/extensions.dart';
import '../entities/user_passport.dart';

enum AuthStatus {
  initial,
  typing,
  submitting,
  failureUserNotFound,
  failureWrongPassword,
  failureAuthenticating,
  successAuthenticating,
  failureNetworkError,
  unknownError,
}

final class AuthState extends Equatable {
  const AuthState({required this.userPassport, required this.status});

  const AuthState.initial()
      : userPassport = const UserPassport.empty(),
        status = AuthStatus.initial;

  final UserPassport userPassport;
  final AuthStatus status;

  // Validators
  String? get emailValidator {
    final email = userPassport.email;
    if (email.isEmpty) return 'O e-mail deve ser preenchido';
    if (!email.isEmail) return 'Este não é um e-mail válido';
    return null;
  }

  @override
  List<Object?> get props => [userPassport, status];

  AuthState copyWith({
    UserPassport? userPassport,
    AuthStatus? status,
  }) {
    return AuthState(
      userPassport: userPassport ?? this.userPassport,
      status: status ?? this.status,
    );
  }
}
