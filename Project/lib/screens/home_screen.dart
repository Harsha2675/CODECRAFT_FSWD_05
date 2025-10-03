import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../models.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Media'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          return ListView.builder(
            itemCount: appState.posts.length,
            itemBuilder: (context, index) {
              final post = appState.posts[index];
              return PostCard(post: post);
            },
          );
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(post.author.avatar),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.author.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (post.author.isVerified)
                            Icon(Icons.verified, color: Colors.blue, size: 16),
                        ],
                      ),
                      Text(
                        '${post.createdAt.hour}:${post.createdAt.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(post.content),
            if (post.tags.isNotEmpty) ...[
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: post.tags.map((tag) => Chip(
                  label: Text('#$tag', style: TextStyle(fontSize: 12)),
                  backgroundColor: Colors.blue.withOpacity(0.1),
                )).toList(),
              ),
            ],
            if (post.imageUrl != null) ...[
              SizedBox(height: 12),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.image, size: 50, color: Colors.grey[600]),
              ),
            ],
            SizedBox(height: 12),
            Row(
              children: [
                Consumer<AppState>(
                  builder: (context, appState, _) {
                    final isLiked = post.likes.contains(appState.currentUserId);
                    return GestureDetector(
                      onTap: () => appState.toggleLike(post.id),
                      child: Row(
                        children: [
                          Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                          ),
                          SizedBox(width: 4),
                          Text('${post.likes.length}'),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => _showCommentsSheet(context, post),
                  child: Row(
                    children: [
                      Icon(Icons.comment_outlined, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('${post.comments.length}'),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Icon(Icons.share_outlined, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCommentsSheet(BuildContext context, Post post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Comments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: post.comments.length,
                itemBuilder: (context, index) {
                  final comment = post.comments[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(comment.author.avatar),
                    ),
                    title: Text(comment.author.name),
                    subtitle: Text(comment.content),
                  );
                },
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Add comment functionality
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}