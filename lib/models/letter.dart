class Letter {
  final String id;
  final String title;
  final String body;
  final String image;
  final String author;
  final String date;
  final String timeToRead;

  Letter({
    required this.id,
    required this.title,
    required this.body,
    required this.image,
    required this.author,
    required this.date,
    required this.timeToRead,
  });

  factory Letter.fromJson(Map<String, dynamic> json) {
    return Letter(
      id: json['id'].toString(),
      title: json['title'] as String,
      body: json['body'] as String,
      image: json['image'] as String,
      author: json['author'] as String,
      date: json['date'] as String,
      timeToRead: json['timeToRead'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'image': image,
      'author': author,
      'date': date,
      'timeToRead': timeToRead,
    };
  }

  @override
  String toString() {
    return 'Letter{title: $title, body: $body, image: $image, author: $author, date: $date, timeToRead: $timeToRead}';
  }
}
