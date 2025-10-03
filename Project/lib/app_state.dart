import 'package:flutter/material.dart';
import 'models.dart';

class AppState extends ChangeNotifier {
  final List<User> _users = [
    User(
      id: '1', 
      name: 'John Doe', 
      bio: 'Flutter Developer', 
      avatar: '👨‍💻', 
      joinDate: DateTime(2023, 1, 1)
    ),
    User(
      id: '2', 
      name: 'Jane Smith', 
      bio: 'UI/UX Designer', 
      avatar: '👩‍🎨', 
      joinDate: DateTime(2023, 2, 1)
    ),
  ];

  final List<Post> _posts = [];
  final List<Map<String, dynamic>> _notifications = [];
  String _currentUserId = '1';

  List<User> get users => _users;
  List<Post> get posts => _posts..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  List<Map<String, dynamic>> get notifications => _notifications;
  String get currentUserId => _currentUserId;
  
  User get currentUser => _users.firstWhere((u) => u.id == _currentUserId);
  User getUserById(String id) => _users.firstWhere((u) => u.id == id);

  void addPost(String content, {String? imageUrl, List<String>? tags}) {
    final post = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: _currentUserId,
      content: content,
      author: currentUser,
      imageUrl: imageUrl,
      tags: tags ?? [],
      createdAt: DateTime.now(),
    );
    _posts.insert(0, post);
    notifyListeners();
  }

  void toggleLike(String postId) {
    final post = _posts.firstWhere((p) => p.id == postId);
    if (post.likes.contains(_currentUserId)) {
      post.likes.remove(_currentUserId);
    } else {
      post.likes.add(_currentUserId);
      _addNotification('like', post.userId, postId);
    }
    notifyListeners();
  }

  void addComment(String postId, String content) {
    final post = _posts.firstWhere((p) => p.id == postId);
    final comment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: _currentUserId,
      content: content,
      author: currentUser,
      createdAt: DateTime.now(),
    );
    post.comments.add(comment);
    _addNotification('comment', post.userId, postId);
    notifyListeners();
  }

  void toggleFollow(String userId) {
    final user = _users.firstWhere((u) => u.id == userId);
    final currentUser = _users.firstWhere((u) => u.id == _currentUserId);
    
    if (currentUser.following.contains(userId)) {
      currentUser.following.remove(userId);
      user.followers.remove(_currentUserId);
    } else {
      currentUser.following.add(userId);
      user.followers.add(_currentUserId);
      _addNotification('follow', userId, null);
    }
    notifyListeners();
  }

  void _addNotification(String type, String userId, String? postId) {
    if (userId != _currentUserId) {
      _notifications.insert(0, {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': type,
        'userId': _currentUserId,
        'postId': postId,
        'createdAt': DateTime.now(),
      });
    }
  }

  List<String> getTrendingHashtags() {
    final tagCounts = <String, int>{};
    for (final post in _posts) {
      for (final tag in post.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }
    final sortedTags = tagCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedTags.take(5).map((e) => e.key).toList();
  }

  List<User> getSuggestedUsers() {
    return _users.where((u) => 
      u.id != _currentUserId && 
      !currentUser.following.contains(u.id)
    ).toList();
  }
}