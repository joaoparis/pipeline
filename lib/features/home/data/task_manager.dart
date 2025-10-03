import 'package:pipeline/features/home/data/data.dart';

class TasksManager {
  final List<List<Task>> _tasks = [];
  int _nextId = 0;

  List<List<Task>> get tasks => List.unmodifiable(_tasks);

  Future<void> loadTasks() async {
    // Simulate loading from DB or file
    await Future.delayed(const Duration(seconds: 1));
    _tasks.clear();
    _tasks.addAll(
      [
        [
          Task(
            id: 1,
            emoji: '😎',
            title: 'Task 1',
            description: 'description',
            startDate: '30/02/2029',
            goalEndDate: '25/12/2029',
            actualEndDate: '08/03/2029',
            color: Colors.red,
          ),
          Task(
            id: 112321,
            emoji: '😎',
            title: 'Task 1',
            description: 'description',
            startDate: '30/02/2029',
            goalEndDate: '25/12/2029',
            actualEndDate: '08/03/2029',
            color: Colors.red,
          ),
        ], // Icebox
        [
          Task(
            id: 4123213,
            emoji: '😎',
            title: 'Task 4',
            description: 'description',
            startDate: '30/02/2029',
            goalEndDate: '25/12/2029',
            actualEndDate: '08/03/2029',
            color: Colors.redAccent,
          ),
          Task(
            id: 4242323,
            emoji: '😎',
            title: 'Task 4',
            description: 'description',
            startDate: '30/02/2029',
            goalEndDate: '25/12/2029',
            actualEndDate: '08/03/2029',
            color: Colors.redAccent,
          ),
        ], // Working
        [
          Task(
            id: 7,
            emoji: '😎',
            title: 'Task 7',
            description: 'description',
            startDate: '30/02/2029',
            goalEndDate: '25/12/2029',
            actualEndDate: '08/03/2029',
            color: Colors.orange,
          ),
          Task(
            id: 323,
            emoji: '😎',
            title: 'Task 7',
            description: 'description',
            startDate: '30/02/2029',
            goalEndDate: '25/12/2029',
            actualEndDate: '08/03/2029',
            color: Colors.orange,
          ),
        ] // Done
      ],
    );
  }

  void addTask(int taskListIndex, String title, Color color) {
    final task = Task(
      id: _nextId++,
      emoji: '🚀',
      title: title,
      description: '',
      startDate: '',
      actualEndDate: '',
      goalEndDate: '',
      color: color,
    );
    _tasks[taskListIndex].add(task);
  }

  void removeTask(int taskListIndex, int id) {
    _tasks[taskListIndex].removeWhere((task) => task.id == id);
  }

  void updateTask(
    int taskListIndex,
    int id, {
    String? emoji,
    String? title,
    String? description,
    String? startDate,
    String? actualEndDate,
    String? goalEndDate,
    Color? color,
  }) {
    final index = _tasks[taskListIndex].indexWhere((task) => task.id == id);
    if (index != -1) {
      final task = _tasks[taskListIndex][index];
      _tasks[taskListIndex][index] = Task(
        id: task.id,
        emoji: emoji ?? task.emoji,
        title: title ?? task.title,
        description: description ?? task.description,
        startDate: startDate ?? task.startDate,
        actualEndDate: actualEndDate ?? task.actualEndDate,
        goalEndDate: goalEndDate ?? task.goalEndDate,
        color: color ?? task.color,
      );
    }
  }
}
