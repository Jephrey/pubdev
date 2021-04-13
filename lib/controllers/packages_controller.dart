import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:pubdev/models/package.dart';
import 'package:pubdev/rss/get_pubdev.dart';

class PackagesController extends GetxController {
  static PackagesController get to => Get.find<PackagesController>();
  Comparator<Package> sortByUpdated = (b, a) => a.updated.compareTo(b.updated);

  final packagesStorage = GetStorage();

  var packages = <Package>[].obs;
  var packagesFilter = <Package>[].obs;
  var search = "".obs;

  // Get the normal list or the searched list.
  List<Package> get packageList {
    if (packagesFilter.isEmpty && search.isEmpty)
      return packages;
    else
      return packagesFilter;
  }

  @override
  void onInit() {
    if (packagesStorage.hasData('packages')) {
      final _packages = packagesStorage.read<List>('packages');
      log('Init: read ${_packages.length} packages');
      for (final p in _packages) {
        //print(p['title']);
        final _p = Package(
          p['title'],
          p['version'],
          p['updated'],
          p['content'],
          p['link'],
          p['isFavorite'],
        );
        packages.add(_p);
      }
      refresh();
    } else {
      log('No packages stored');
    }
    super.onInit();
  }

  void getPackagesFromRss() {
    getPubDev();
    sortPackageList();
    savePackagesList();
  }

  @override
  void onClose() {
    savePackagesList();
    super.onClose();
  }

  void savePackagesList() async {
    await packagesStorage.write('packages', packages.toList());
    log('Saved ${packages.length} packages');
  }

  void addPackage(
    String title,
    String version,
    String updated,
    String content,
    String link,
  ) {
    var p = packages.firstWhere((package) => package.title == title, orElse: () => null);
    if (p != null) {
      log("Updated ${p.title}");
      p.version = version;
      p.updated = updated;
      p.content = content;
      p.link = link;
    } else {
      p = Package(
        title,
        version,
        updated,
        content,
        link,
        false,
      );
      log("Added ${p.title}");
      packages.insert(0, p);
    }
  }

  // Search for text in the package list.
  void searchPackageList(String text) {
    search.value = text;
    packagesFilter.clear();

    if (text.isNotEmpty) {
      packages.forEach((package) {
        if (package.title.contains(text)) packagesFilter.add(package);
      });
    }
  }

  void sortPackageList() {
    packageList.sort(sortByUpdated);
  }
}
