import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:weather_test/core/utils/logger.dart';
import 'package:weather_test/features/app/presentation/app/logic/app_launcher.dart';

void main() {
  logger.runLogging(
    () => runZonedGuarded(
      () async => await const AppLauncher().initializeAndRun(),
      logger.logZoneError,
    ),
    const LogOptions(
      level: kDebugMode ? LoggerLevel.debug : LoggerLevel.info,
    ),
  );
}
