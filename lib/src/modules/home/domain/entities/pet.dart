import 'package:equatable/equatable.dart';

import 'pet_type.dart';

final class Pet extends Equatable {
  const Pet({
    required this.id,
    required this.name,
    required this.photo,
    required this.type,
    required this.breed,
    required this.age,
    required this.weight,
    required this.birthday,
    required this.gender,
    required this.notes,
  });

  const Pet.empty()
      : id = '',
        name = '',
        photo = '',
        type = PetType.none,
        breed = '',
        age = '',
        weight = '',
        birthday = '',
        gender = '',
        notes = '';

  final String id;
  final String name;
  final String photo;
  final PetType type;
  final String breed;
  final String age;
  final String weight;
  final String birthday;
  final String gender;
  final String notes;

  @override
  List<Object> get props {
    return [
      id,
      name,
      photo,
      type,
      breed,
      age,
      weight,
      birthday,
      gender,
      notes,
    ];
  }

  Pet copyWith({
    String? id,
    String? name,
    String? photo,
    PetType? type,
    String? breed,
    String? age,
    String? weight,
    String? birthday,
    String? gender,
    String? notes,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      type: type ?? this.type,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      notes: notes ?? this.notes,
    );
  }
}
