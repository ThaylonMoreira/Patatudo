import 'package:equatable/equatable.dart';

final class UserPassport extends Equatable {
  const UserPassport({
    required this.id,
    required this.email,
    required this.password,
  });

  const UserPassport.empty()
      : id = '',
        email = '',
        password = '';

  final String id;
  final String email;
  final String password;

  @override
  List<Object?> get props => [
        id,
        email,
        password,
      ];

  UserPassport copyWith({
    String? id,
    String? email,
    String? password,
  }) {
    return UserPassport(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
