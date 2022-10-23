// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'entry.g.dart';

@HiveType(typeId: 5)
class Entry {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double amount;

  @HiveField(3)
  DateTime date;

  Entry({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
}
