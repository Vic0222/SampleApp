class News {
  const News(
    this.by,
    this.descendants,
    this.id,
    this.kids,
    this.score,
    this.time,
    this.title,
    this.type,
    this.url,
  );

  final String by;
  final int descendants;
  final int id;
  final List<int> kids;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  static const News empty = News(
    "",
    0,
    0,
    <int>[],
    0,
    0,
    "",
    "",
    "",
  );

  factory News.fromJson(Map<String, dynamic> json) => News(
        json["by"],
        json["descendants"],
        json["id"],
        List<int>.from(json["kids"].map((x) => x)),
        json["score"],
        json["time"],
        json["title"],
        json["type"],
        json["url"],
      );

  Map<String, dynamic> toJson() => {
        "by": by,
        "descendants": descendants,
        "id": id,
        "kids": List<dynamic>.from(kids.map((x) => x)),
        "score": score,
        "time": time,
        "title": title,
        "type": type,
        "url": url,
      };
}
