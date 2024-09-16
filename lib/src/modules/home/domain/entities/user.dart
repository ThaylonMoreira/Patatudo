import 'package:equatable/equatable.dart';

import 'pet.dart';

final class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.pets,
  });

  User.empty()
      : id = '',
        name = '',
        email = '',
        password = '',
        pets = [const Pet.empty()];

  final String id;
  final String name;
  final String email;
  final String password;
  final List<Pet> pets;

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      password,
      pets,
    ];
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    List<Pet>? pets,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      pets: pets ?? this.pets,
    );
  }
}
