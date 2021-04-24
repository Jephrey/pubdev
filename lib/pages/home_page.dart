import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:pubdev/controllers/packages_controller.dart';
import 'package:pubdev/widgets/package_list.dart';

class HomePage extends StatelessWidget {
  final pc = Get.find<PackagesController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('PubDev'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                pc.savePackagesList();
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                pc.getPackagesFromRss();
              },
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text('${pc.packages.length} packages')),
            OutlineSearchBar(
              hintText: 'Search',
              searchButtonPosition: SearchButtonPosition.leading,
              onKeywordChanged: (keyword) => pc.searchPackageList(keyword),
            ),
            Flexible(
              child: PackageList(),
            ),
          ],
        ),
      ),
    );
  }
}
