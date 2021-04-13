import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:dart_rss/dart_rss.dart';

import 'package:pubdev/controllers/packages_controller.dart';

void getPubDev() {
  final client = http.Client();
  final pc = Get.find<PackagesController>();

  // Atom feed.
  client.get(Uri.parse('https://pub.dev/feed.atom')).then((response) {
    return response.body;
  }).then((bodyString) {
    final feed = AtomFeed.parse(bodyString);
    for (AtomItem item in feed.items) {
      String title = item.title.split(" ").last;
      String version = item.title.split(" ").first;
      pc.addPackage(
        title,
        version,
        item.updated,
        item.content,
        item.links.first.href,
      );
    }
    return feed;
  });
}
