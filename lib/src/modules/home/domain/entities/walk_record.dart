import 'package:equatable/equatable.dart';

final class WalkRecord extends Equatable {
  const WalkRecord({
    required this.id,
    required this.petId,
    required this.date,
    required this.duration,
    required this.distance,
    required this.notes,
  });

  const WalkRecord.empty()
      : id = '',
        petId = '',
        date = '',
        duration = '',
        distance = '',
        notes = '';

  final String id;
  final String petId;
  final String date;
  final String duration;
  final String distance;
  final String notes;

  @override
  List<Object> get props {
    return [
      id,
      petId,
      date,
      duration,
      distance,
      notes,
    ];
  }

  WalkRecord copyWith({
    String? id,
    String? petId,
    String? date,
    String? duration,
    String? distance,
    String? notes,
  }) {
    return WalkRecord(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      date: date ?? this.date,
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
      notes: notes ?? this.notes,
    );
  }
}
