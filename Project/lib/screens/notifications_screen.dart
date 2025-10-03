import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          final notifications = appState.notifications;

          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final user = appState.getUserById(notification['userId']);
              
              return ListTile(
                leading: CircleAvatar(
                  child: Text(user.avatar),
                ),
                title: Text(_getNotificationTitle(notification, user.name)),
                subtitle: Text(_getTimeAgo(notification['createdAt'])),
                trailing: _getNotificationIcon(notification['type']),
              );
            },
          );
        },
      ),
    );
  }

  String _getNotificationTitle(Map<String, dynamic> notification, String userName) {
    switch (notification['type']) {
      case 'like':
        return '$userName liked your post';
      case 'comment':
        return '$userName commented on your post';
      case 'follow':
        return '$userName started following you';
      default:
        return 'New notification';
    }
  }

  Widget _getNotificationIcon(String type) {
    switch (type) {
      case 'like':
        return Icon(Icons.favorite, color: Colors.red);
      case 'comment':
        return Icon(Icons.comment, color: Colors.blue);
      case 'follow':
        return Icon(Icons.person_add, color: Colors.green);
      default:
        return Icon(Icons.notifications);
    }
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}