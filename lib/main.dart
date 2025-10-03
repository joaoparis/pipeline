import 'package:pipeline/features/home/data/task_manager.dart';
import 'package:pipeline/pipeline.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider<TasksManager>(
      create: (_) => TasksManager(),
      child: PipelineApp(),
    ),
  );
}
