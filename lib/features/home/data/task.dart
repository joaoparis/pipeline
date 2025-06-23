import 'data.dart';

class Task {
  final String id;
  final String emoji;
  final String title;
  final String description;
  final String startDate;
  final String actualEndDate;
  final String goalEndDate;
  final Color color;

  Task(this.id, this.emoji, this.title, this.description, this.startDate,
      this.actualEndDate, this.goalEndDate, this.color);

  @override
  bool operator ==(Object other) => other is Task && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
