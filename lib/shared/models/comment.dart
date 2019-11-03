part of models;

class Comment {
  final int id;
  final String body;
  final Author author;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment({this.id, this.body, this.author, this.createdAt, this.updatedAt});

  static fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        body: json['body'],
        author: Author.fromJson(json['author']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'body': body,
    'author': author,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}
