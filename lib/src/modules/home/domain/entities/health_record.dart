import 'package:equatable/equatable.dart';

final class HealthRecord extends Equatable {
  const HealthRecord({
    required this.id,
    required this.petId,
    required this.date,
    required this.recordType,
    required this.description,
    required this.veterinarian,
    required this.file,
  });
  final String id;
  final String petId;
  final String date;
  final String recordType;
  final String description;
  final String veterinarian;
  final String file;

  const HealthRecord.empty()
      : id = '',
        petId = '',
        date = '',
        recordType = '',
        description = '',
        veterinarian = '',
        file = '';

  @override
  List<Object> get props {
    return [
      id,
      petId,
      date,
      recordType,
      description,
      veterinarian,
      file,
    ];
  }

  HealthRecord copyWith({
    String? id,
    String? petId,
    String? date,
    String? recordType,
    String? description,
    String? veterinarian,
    String? file,
  }) {
    return HealthRecord(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      date: date ?? this.date,
      recordType: recordType ?? this.recordType,
      description: description ?? this.description,
      veterinarian: veterinarian ?? this.veterinarian,
      file: file ?? this.file,
    );
  }
}
