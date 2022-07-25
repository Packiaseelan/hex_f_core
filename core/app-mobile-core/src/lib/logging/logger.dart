import 'dart:io';

import 'package:core/analytics/i_analytics.dart';
import 'package:core/ioc/di_container.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'logger_level.dart';

class HexLogger {
  static const _appName = 'ADQ';
  static var _logger = Logger(output: PSConsoleOutput());
  static var logs = <String>[];
  static String? environment;
  static IAnalytics? _analytics;

  void setLogLevels(LoggerLevel loggerLevel) {
    var level = Level.nothing;

    switch (loggerLevel) {
      case LoggerLevel.DEBUG:
        level = Level.debug;
        break;

      case LoggerLevel.ERROR:
        level = Level.error;
        break;

      case LoggerLevel.WARN:
        level = Level.warning;
        break;

      case LoggerLevel.INFO:
        level = Level.verbose;
        break;

      default:
        level = Level.nothing;
    }

    _logger = Logger(output: PSConsoleOutput(), level: level);
  }

  /// Logs a the [msg] to the device's console if the device is compiled in
  /// debug mode.
  ///
  /// The primary level of logging. Most logging statements should be
  /// debug messages to trace the flow of the program in debug mode but also
  /// to prevent anyone who has a release build of the application from learning
  /// too much about the flow and logic of the application.
  static void logDebug<T>(String msg) {
    final detailedMessage = _getDetailedMessage(msg, LoggerLevel.DEBUG, T.toString());
    if (detailedMessage.isNotEmpty) _logMessage(Level.debug, detailedMessage);
  }

  /// Logs the [msg] to the device's console.
  ///
  /// The informative logging method should be used sparingly for major changes
  /// in the flow of the program to provide some context on how the user is using
  /// the application
  static void logInfo<T>(String msg) {
    final detailedMessage = _getDetailedMessage(msg, LoggerLevel.INFO, T.toString());
    if (detailedMessage.isNotEmpty) _logMessage(Level.info, detailedMessage);
  }

  /// Logs the [msg] to the device's console.
  ///
  /// The warning logging method should be used only when the developer wants
  /// to log a warning to the console.
  static void logWarning<T>(String msg) async {
    final detailedMessage = _getDetailedMessage(msg, LoggerLevel.WARN, T.toString());
    if (detailedMessage.isNotEmpty) {
      _logInAnalytics(
        'warning',
        {'warningMsg': detailedMessage},
      );

      _logMessage(Level.warning, detailedMessage);
    }
  }

  /// Logs the [msg] to the device's console.
  ///
  /// The error logging method should be used only when the developer wants
  /// to log an error to the console.
  /// todo: debate on sending error remotely also.
  static void logError<T>(String msg) async {
    final detailedMessage = _getDetailedMessage(msg, LoggerLevel.ERROR, T.toString());
    if (detailedMessage.isNotEmpty) {
      _logInAnalytics(
        'error',
        {'errorMsg': detailedMessage},
      );

      _logMessage(Level.error, detailedMessage);
    }
  }

  // generic logging method
  static String _getDetailedMessage(
    String msg,
    LoggerLevel level,
    String classType,
  ) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return '';
    }
    final dateTime = DateTime.now();
    final levelString = level.toString().split('.').last;
    final formattedTime = '${dateTime.hour.toString()}:${dateTime.minute.toString()}:${dateTime.second.toString()}';
    final contents = '[$_appName] [$formattedTime] [$classType] [$levelString] - $msg';
    return contents;
  }

  static void _logMessage(Level level, String msg) async {
    if (!kReleaseMode) {
      _logger.log(level, msg);
    } else {
      logs.add(msg);
    }
  }

  static void _logInAnalytics(String eventName, Map<String, dynamic>? properties) {
    if (kReleaseMode) {
      if (_analytics == null) {
        try {
          _analytics = DIContainer.container.resolve<IAnalytics>();
        } on Exception catch (exception) {
          // do nothing
          HexLogger.logDebug('could not find analytics object');
        }
      }

      _analytics?.logEvent(eventName, properties);
    }
  }
}

class PSConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    // TODO: implement output
    HexLogger.logs.addAll(event.lines);
    event.lines.forEach((element) {
      print(element);
    });
  }
}
