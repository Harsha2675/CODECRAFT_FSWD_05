class User {
  final String id, name, bio, avatar;
  final List<String> followers, following;
  final bool isVerified;
  final DateTime joinDate;
  
  User({
    required this.id,
    required this.name,
    required this.bio,
    required this.avatar,
    this.followers = const [],
    this.following = const [],
    this.isVerified = false,
    required this.joinDate,
  });
}

class Post {
  final String id, userId, content;
  final String? imageUrl;
  final List<String> likes, tags;
  final List<Comment> comments;
  final DateTime createdAt;
  final User author;
  
  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.author,
    this.imageUrl,
    this.likes = const [],
    this.tags = const [],
    this.comments = const [],
    required this.createdAt,
  });
}

class Comment {
  final String id, userId, content;
  final DateTime createdAt;
  final User author;
  
  Comment({
    required this.id,
    required this.userId,
    required this.content,
    required this.author,
    required this.createdAt,
  });
}