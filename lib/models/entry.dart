// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

class Entry {
  String id;
  String title;
  double amount;
  DateTime date;
  Entry({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
}
