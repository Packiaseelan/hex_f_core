import 'package:core/task/task_params.dart';

abstract class ITask {
  Future waitOnTask<T>(TaskParams? parameters) async {
    throw UnimplementedError();
  }
}
