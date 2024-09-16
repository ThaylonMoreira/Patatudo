import '../../domain/entities/appointment.dart';
import '../../domain/entities/feeding_record.dart';
import '../../domain/entities/health_record.dart';
import '../../domain/entities/pet.dart';
import '../../domain/entities/pet_type.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/walk_record.dart';

class FirestoreAdapter {
  static Map<String, dynamic> appointmentToDocument(Appointment appointment) {
    return {
      'id': appointment.id,
      'petId': appointment.petId,
      'dateTime': appointment.dateTime,
      'type': appointment.type,
      'location': appointment.location,
      'notes': appointment.notes,
    };
  }

  static Appointment appointmentFromMap(Map<String, dynamic> doc) {
    return Appointment(
      id: doc['id'],
      petId: doc['petId'],
      dateTime: doc['dateTime'],
      type: doc['type'],
      location: doc['location'],
      notes: doc['notes'],
    );
  }

  static Map<String, dynamic> feedingRecordToDocument(
      FeedingRecord feedingRecord) {
    return {
      'id': feedingRecord.id,
      'petId': feedingRecord.petId,
      'date': feedingRecord.date,
      'foodType': feedingRecord.foodType,
      'quantity': feedingRecord.quantity,
      'notes': feedingRecord.notes,
    };
  }

  static FeedingRecord feedingRecordFromMap(Map<String, dynamic> doc) {
    return FeedingRecord(
      id: doc['id'],
      petId: doc['petId'],
      date: doc['date'],
      foodType: doc['foodType'],
      quantity: doc['quantity'],
      notes: doc['notes'],
    );
  }

  static Map<String, dynamic> healthRecordToDocument(
      HealthRecord healthRecord) {
    return {
      'id': healthRecord.id,
      'petId': healthRecord.petId,
      'date': healthRecord.date,
      'recordType': healthRecord.recordType,
      'description': healthRecord.description,
      'veterinarian': healthRecord.veterinarian,
      'file': healthRecord.file,
    };
  }

  static HealthRecord healthRecordFromMap(Map<String, dynamic> doc) {
    return HealthRecord(
      id: doc['id'],
      petId: doc['petId'],
      date: doc['date'],
      recordType: doc['recordType'],
      description: doc['description'],
      veterinarian: doc['veterinarian'],
      file: doc['file'],
    );
  }

  static Map<String, dynamic> petToDocument(Pet pet) {
    return {
      'id': pet.id,
      'name': pet.name,
      'photo': pet.photo,
      'type': pet.type,
      'breed': pet.breed,
      'age': pet.age,
      'weight': pet.weight,
      'birthday': pet.birthday,
      'gender': pet.gender,
      'notes': pet.notes,
    };
  }

  static Pet petFromMap(Map<String, dynamic> doc) {
    return Pet(
      id: doc['id'],
      name: doc['name'],
      photo: doc['photo'],
      type: PetType.values.byName(doc['type']),
      breed: doc['breed'],
      age: doc['age'],
      weight: doc['weight'],
      birthday: doc['birthday'],
      gender: doc['gender'],
      notes: doc['notes'],
    );
  }

  static Map<String, dynamic> reminderToDocument(Reminder reminder) {
    return {
      'id': reminder.id,
      'petId': reminder.petId,
      'dateTime': reminder.dateTime.toIso8601String(),
      'type': reminder.type,
      'description': reminder.description,
    };
  }

  static Reminder reminderFromMap(Map<String, dynamic> doc) {
    return Reminder(
      id: doc['id'],
      petId: doc['petId'],
      dateTime: DateTime.parse(doc['dateTime']),
      type: ReminderType.values.byName(doc['type']),
      description: doc['description'],
    );
  }

  static Map<String, dynamic> userToDocument(User user) {
    return {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'pets': user.pets.map((pet) => petToDocument(pet)).toList(),
    };
  }

  static User userFromMap(Map<String, dynamic> doc) {
    return User(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      password: doc['password'],
      pets: <Map<String, dynamic>>[...doc['pets'] ?? []]
          .map((pet) => petFromMap(pet))
          .toList(),
    );
  }

  static Map<String, dynamic> walkRecordToDocument(WalkRecord walkRecord) {
    return {
      'id': walkRecord.id,
      'petId': walkRecord.petId,
      'date': walkRecord.date,
      'duration': walkRecord.duration,
      'distance': walkRecord.distance,
      'notes': walkRecord.notes,
    };
  }

  static WalkRecord walkRecordFromMap(Map<String, dynamic> doc) {
    return WalkRecord(
      id: doc['id'],
      petId: doc['petId'],
      date: doc['date'],
      duration: doc['duration'],
      distance: doc['distance'],
      notes: doc['notes'],
    );
  }
}
