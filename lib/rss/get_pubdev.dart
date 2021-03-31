import 'package:http/http.dart' as http;
import 'package:dart_rss/dart_rss.dart';

void getPubDev() {
  final client = http.Client();

  // Atom feed
  client.get(Uri.parse('https://pub.dev/feed.atom')).then((response) {
    return response.body;
  }).then((bodyString) {
    final feed = AtomFeed.parse(bodyString);
    for (AtomItem item in feed.items) {
      print(item.title);
      print(item.updated);
      print(item.content);
    }
    return feed;
  });
}
