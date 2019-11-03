part of models;

class Article {
  final String title;
  final String slug;
  final String description;
  final String body;
  final Author author;
  final bool favorited;
  final int favoritesCount;
  final List tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  Article({
    this.title,
    this.slug,
    this.description,
    this.body,
    this.author,
    this.favorited,
    this.favoritesCount,
    this.tags,
    this.createdAt,
    this.updatedAt,
  });

  static Article fromJson(Map<String, dynamic> json) {
    return Article(
        title: json['title'],
        slug: json['slug'],
        description: json['description'],
        body: json['body'],
        author: Author.fromJson(json['author']),
        favorited: json['favorited'],
        favoritesCount: json['favoritesCount'],
        tags: json['tagList'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'slug': slug,
    'description': description,
    'body': body,
    'author': author.toJson(),
    'tagList': tags,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
