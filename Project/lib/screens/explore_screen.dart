import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          final trendingTags = appState.getTrendingHashtags();
          final suggestedUsers = appState.getSuggestedUsers();

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trending Hashtags',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: trendingTags.map((tag) => Chip(
                    label: Text('#$tag'),
                    backgroundColor: Colors.blue.withOpacity(0.1),
                  )).toList(),
                ),
                SizedBox(height: 24),
                Text(
                  'Suggested Users',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                ...suggestedUsers.map((user) => Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.avatar),
                    ),
                    title: Row(
                      children: [
                        Text(user.name),
                        if (user.isVerified)
                          Icon(Icons.verified, color: Colors.blue, size: 16),
                      ],
                    ),
                    subtitle: Text(user.bio),
                    trailing: ElevatedButton(
                      onPressed: () => appState.toggleFollow(user.id),
                      child: Text('Follow'),
                    ),
                  ),
                )).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}