import 'package:equatable/equatable.dart';

abstract base class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthEmailInputed extends AuthEvent {
  const AuthEmailInputed({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

final class AuthPasswordInputed extends AuthEvent {
  const AuthPasswordInputed({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

final class AuthSubmitted extends AuthEvent {
  const AuthSubmitted();
}
