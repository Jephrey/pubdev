import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pubdev/pages/detail_page.dart';
import 'package:pubdev/pages/home_page.dart';

import 'controllers/packages_controller.dart';
import 'controllers/preferences_controller.dart';
import 'controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  log(window.locale.toString());
  Intl.defaultLocale = window.locale.languageCode;
  await initializeDateFormatting(window.locale.countryCode);

  await GetStorage.init();
  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<Preferences>(() => Preferences());
  Get.lazyPut<PackagesController>(() => PackagesController());

  runApp(PubDevApp());
}

class PubDevApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pub.dev',
      theme: ThemeData.light().copyWith(primaryColor: Colors.lightGreen),
      darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.green),
      themeMode: ThemeController.to.theme.value,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(name: '/detail', page: () => DetailPage()),
      ],
      home: HomePage(),
    );
  }
}
