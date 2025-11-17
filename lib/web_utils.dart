import 'package:flutter/foundation.dart';

void notifyWebAppReady() {
  if (kIsWeb) {
    debugPrint('Flutter ready');
  }
}