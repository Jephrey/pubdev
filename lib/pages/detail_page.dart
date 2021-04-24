import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:pubdev/controllers/packages_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final _package = PackagesController.to.packageList[Get.arguments];
  final _date = DateTime.parse(PackagesController.to.packageList[Get.arguments].updated).toLocal();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('PubDev Detail Page'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${_package.title}'),
            Text('Version: ${_package.version}'),
            Text(
                //'Updated: ${DateFormat('d MMMM yyyy hh:mm', Localizations.localeOf(context).languageCode).format(_date)}'),
                'Updated: ${DateFormat().format(_date)}'),
            InkWell(
              child: Text('Link: ${_package.link}'),
              onTap: () => launch(_package.link),
            ),
            Flexible(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Html(
                    shrinkWrap: true,
                    data: _package.content,
                    onLinkTap: (String url) {
                      _launchURL(url);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : Get.snackbar(
          'Error',
          'Could not launch $_url',
          backgroundColor: Theme.of(Get.context).errorColor,
        );
}
