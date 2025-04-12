// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';

Future setSystemNavBarColorForThemeMode(
  BuildContext context,
  String themeMode,
) async {
  // Add your function code here!
  try {
    const lightModeColor = Color(0xFFF6C169);
    const darkModeColor = Color(0xFF4D03E7);

    Color navBarColor;

    if (themeMode == 'system') {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      navBarColor =
          brightness == Brightness.dark ? darkModeColor : lightModeColor;
    } else if (themeMode == 'dark') {
      navBarColor = darkModeColor;
    } else {
      navBarColor = lightModeColor;
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: navBarColor,
      systemNavigationBarIconBrightness: _getIconBrightness(navBarColor),
    ));

    print('Nav bar color updated for $themeMode mode');
  } catch (e) {
    print('Error setting system nav bar color: $e');
  }
}

Brightness _getIconBrightness(Color color) {
  final luminance = color.computeLuminance();
  return luminance > 0.5 ? Brightness.dark : Brightness.light;
}
