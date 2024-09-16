import 'package:equatable/equatable.dart';

enum ReminderType { none, vaccine, checkup, feeding }

final class Reminder extends Equatable {
  const Reminder({
    required this.id,
    required this.petId,
    required this.dateTime,
    required this.type,
    required this.description,
  });

  Reminder.empty()
      : id = '',
        petId = '',
        dateTime = DateTime(0),
        type = ReminderType.none,
        description = '';

  final String id;
  final String petId;
  final DateTime dateTime;
  final ReminderType type;
  final String description;
  @override
  List<Object> get props {
    return [
      id,
      petId,
      dateTime,
      type,
      description,
    ];
  }

  Reminder copyWith({
    String? id,
    String? petId,
    DateTime? dateTime,
    ReminderType? type,
    String? description,
  }) {
    return Reminder(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }
}
