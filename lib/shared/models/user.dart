part of models;

class User {
  final int id;
  final String username;
  final String email;
  final String bio;
  final String image;
  final String token;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    this.id,
    this.username,
    this.email,
    this.bio,
    this.image,
    this.token,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        bio = json['bio'],
        image = json['image'],
        token = json['token'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'bio': bio,
        'image': image,
        'token': token,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': createdAt.toIso8601String(),
      };
}
