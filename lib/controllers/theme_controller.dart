import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pubdev/controllers/preferences_controller.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find<ThemeController>();

  var theme = ThemeMode.dark.obs;
  ThemeMode get themeMode => theme.value;

  setThemeMode(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
    theme.value = themeMode;
    Preferences.to.theme = themeMode.toString().split('.')[1];
  }

  getThemeMode() {
    ThemeMode themeMode;
    String themeText = Preferences.to.theme;
    try {
      themeMode =
          ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      themeMode = ThemeMode.system;
    }
    setThemeMode(themeMode);
  }
}
