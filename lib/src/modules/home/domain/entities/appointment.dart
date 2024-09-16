import 'package:equatable/equatable.dart';

enum AppointmentType { none, checkup, grooming }

final class Appointment extends Equatable {
  const Appointment({
    required this.id,
    required this.petId,
    required this.dateTime,
    required this.type,
    required this.location,
    required this.notes,
  });
  final String id;
  final String petId;
  final DateTime dateTime;
  final AppointmentType type;
  final String location;
  final String notes;

  Appointment.empty()
      : id = '',
        petId = '',
        dateTime = DateTime(0),
        type = AppointmentType.none,
        location = '',
        notes = '';

  @override
  List<Object> get props {
    return [
      id,
      petId,
      dateTime,
      type,
      location,
      notes,
    ];
  }

  Appointment copyWith({
    String? id,
    String? petId,
    DateTime? dateTime,
    AppointmentType? type,
    String? location,
    String? notes,
  }) {
    return Appointment(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      location: location ?? this.location,
      notes: notes ?? this.notes,
    );
  }
}
