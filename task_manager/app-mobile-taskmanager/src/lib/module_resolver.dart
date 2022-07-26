import 'package:task_manager/task_manager.dart';

abstract class ModuleResolver {
  static final Map<String, ModuleResolver> _resolverMap = <String, ModuleResolver>{};

  static void registerResolver(String moduleIdentifier, ModuleResolver resolver) {
    _resolverMap.putIfAbsent(moduleIdentifier, () => resolver);
  }

  static void unRegisterResolver(String moduleIdentifier) {
    _resolverMap.remove(moduleIdentifier);
  }

  static TaskResolver? getTaskResolver(String moduleIdentifier, TaskType type) {
    return _resolverMap[moduleIdentifier]!.taskResolver(type);
  }

  TaskResolver taskResolver(TaskType type);
}
