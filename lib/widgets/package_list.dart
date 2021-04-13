import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pubdev/controllers/packages_controller.dart';

class PackageList extends StatelessWidget {
  final pc = Get.find<PackagesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          itemCount: pc.packageList.length,
          itemBuilder: (context, index) {
            final package = pc.packageList[index];
            return ListTile(
              title: Text(package.title),
              subtitle: Text(package.version),
              dense: true,
              onTap: () => Get.toNamed('/detail', arguments: index),
            );
          },
        ));
  }
}
