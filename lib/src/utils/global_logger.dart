import 'package:logger/logger.dart';

import '../constants/app_values.dart';

class GlobalLogger {
  late final Logger logger;

  GlobalLogger() {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: AppValues.loggerMethodCount,
        // number of method calls to be displayed
        errorMethodCount: AppValues.loggerErrorMethodCount,
        // number of method calls if stacktrace is provided
        lineLength: AppValues.loggerLineLength,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
      ),
    );
  }
}
