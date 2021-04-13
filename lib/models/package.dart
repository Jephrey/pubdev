class Package {
  String title;
  String version;
  String updated;
  String content;
  String link;
  bool isFavorite;

  Package(this.title, this.version, this.updated, this.content, this.link, this.isFavorite);

  Package.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        version = json['version'],
        updated = json['updated'],
        content = json['content'],
        link = json['link'],
        isFavorite = json['isFavorite'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'version': version,
      'updated': updated,
      'content': content,
      'link': link,
      'isFavorite': isFavorite,
    };
  }
}
