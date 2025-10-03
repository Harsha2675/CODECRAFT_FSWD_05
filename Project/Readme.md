# Social Media App

A minimal Flutter social media application with core features for user interaction.

## Features

### Core Features
- ✅ User profiles with avatar and stats
- ✅ Create posts with text content
- ✅ Image/video upload support (image picker integrated)
- ✅ Post tagging system with hashtags
- ✅ Like posts functionality
- ✅ Comment on posts
- ✅ View comments in modal sheet

### Optional Features
- ✅ Follow/unfollow users
- ✅ Notifications for likes and comments
- ✅ Explore trending tags and suggested users
- ✅ User feed with chronological posts

## Screens

1. **Home Feed** - View all posts with like/comment functionality
2. **Explore** - Discover trending tags and users to follow
3. **Notifications** - See interactions on your posts
4. **Profile** - View user stats and their posts
5. **Create Post** - Add new posts with tags and images

## Getting Started

1. Run `flutter pub get` to install dependencies
2. Run `flutter run` to start the app

## Dependencies

- `provider` - State management
- `image_picker` - Image selection functionality

## Architecture

- **Models**: User, Post, Comment data structures
- **State Management**: Provider pattern with AppState
- **Screens**: Modular screen components
- **Navigation**: Bottom navigation with 4 tabs

## Project Structure

```
lib/
├── main.dart              # App entry point
├── models.dart            # Data models
├── app_state.dart         # State management
└── screens/
    ├── home_screen.dart
    ├── explore_screen.dart
    ├── notifications_screen.dart
    ├── profile_screen.dart
    └── create_post_screen.dart
```

## Installation

1. Clone this repository
2. Navigate to the project directory
3. Run `flutter pub get`
4. Run `flutter run`

## Contributing

Feel free to submit issues and enhancement requests!