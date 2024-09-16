import 'package:equatable/equatable.dart';

final class FeedingRecord extends Equatable {
  const FeedingRecord({
    required this.id,
    required this.petId,
    required this.date,
    required this.foodType,
    required this.quantity,
    required this.notes,
  });
  final String id;
  final String petId;
  final String date;
  final String foodType;
  final String quantity;
  final String notes;

  const FeedingRecord.empty()
      : id = '',
        petId = '',
        date = '',
        foodType = '',
        quantity = '',
        notes = '';

  @override
  List<Object> get props {
    return [
      id,
      petId,
      date,
      foodType,
      quantity,
      notes,
    ];
  }

  FeedingRecord copyWith({
    String? id,
    String? petId,
    String? date,
    String? foodType,
    String? quantity,
    String? notes,
  }) {
    return FeedingRecord(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      date: date ?? this.date,
      foodType: foodType ?? this.foodType,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
    );
  }
}
