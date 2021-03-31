import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pubdev/pages/home_page.dart';

import 'controllers/preferences_controller.dart';
import 'controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<Preferences>(() => Preferences());

  runApp(PubSpecApp());
}

class PubSpecApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pub.dev',
      theme: ThemeData.light().copyWith(primaryColor: Colors.lightGreen),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.green),
      themeMode: ThemeController.to.theme.value,
      home: HomePage(),
    );
  }
}
