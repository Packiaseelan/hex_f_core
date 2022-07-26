import 'package:core/task/task_params.dart';
import 'package:task_manager/task.dart';

class AppLaunchDataOperationParams extends TaskParams {
  final List<Task>? tasks;

  AppLaunchDataOperationParams({this.tasks});
}
