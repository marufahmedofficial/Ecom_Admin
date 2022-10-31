import 'package:cloud_firestore/cloud_firestore.dart';

class DateModel {
  Timestamp timestamp;
  num day, month, year;

  DateModel({
    required this.timestamp,
    required this.day,
    required this.month,
    required this.year,
  });
}
