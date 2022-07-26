import 'package:core/task/task_params.dart';

abstract class TaskResolver {
  Future<dynamic> execute(
    String identifier,
    TaskParams? params,
  );
}
