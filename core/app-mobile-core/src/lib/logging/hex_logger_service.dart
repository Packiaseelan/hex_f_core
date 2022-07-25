import 'package:core/logging/logger.dart';
import 'package:core/logging/logger_level.dart';
import 'package:core/task/i_task.dart';
import 'package:core/task/task_params.dart';

enum HexLoggerServiceType {
  getLogs,
  setLevel,
  getLevel,
}

class PSLoggerServiceParams extends TaskParams {
  final HexLoggerServiceType type;
  final LoggerLevel? level;

  PSLoggerServiceParams({required this.type, this.level});
}

class PSLoggerService extends ITask {
  static const identifier = 'logger_service';

  final HexLogger instance;

  PSLoggerService({required this.instance});

  @override
  Future waitOnTask<T>(TaskParams? args) async {
    final params = args as PSLoggerServiceParams;

    switch (params.type) {
      case HexLoggerServiceType.getLogs:
        return Future.value(HexLogger.logs);

      case HexLoggerServiceType.setLevel:
        instance.setLogLevels(params.level!);
        return Future.value(true);

      default:
        throw UnimplementedError();
    }
  }
}
