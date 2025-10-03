import 'package:pipeline/features/home/data/data.dart';

class Task {
  final int id;
  final String emoji;
  final String title;
  final String description;
  final String startDate;
  final String actualEndDate;
  final String goalEndDate;
  final Color color;

  Task({
    required this.id,
    required this.emoji,
    required this.title,
    required this.description,
    required this.startDate,
    required this.actualEndDate,
    required this.goalEndDate,
    required this.color,
  });

  @override
  bool operator ==(Object other) => other is Task && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
