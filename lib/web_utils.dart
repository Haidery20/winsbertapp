import 'package:flutter/foundation.dart';

// Conditional import for web functionality
void notifyWebAppReady() {
  if (kIsWeb) {
    // ignore: avoid_web_libraries_in_flutter
    import('dart:html');
    // ignore: undefined_function
    js.context.callMethod('notifyFlutterReady');
  }
}