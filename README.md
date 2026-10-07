A production-style Flutter Image Gallery application built using the **Pixabay API**.

The application allows users to browse images, search for images, filter images by category, view image details, download images, mark images as favorites, and browse favorite images.

The project follows a clean and maintainable architecture with **BLoC state management** and separation of data, repository, business logic, and presentation layers.

---

##  Features

### Core Features

- Browse images from Pixabay API
- Infinite scrolling / pagination
- Responsive GridView layout
- Search images
- Filter images by category
- Pull-to-refresh
- Image detail screen
- Add/remove images from favorites
- Favorites screen
- Download/save images
- Download progress indicator
- Cached image loading for better performance
- Loading and error states
- Retry after API failure

---

# Tech Stack

- **Flutter**
- **Dart**
- **BLoC / flutter_bloc** - State management
- **Dio** - REST API/networking
- **GetIt** - Dependency injection
- **SharedPreferences** - Local favorites storage
- **CachedNetworkImage** - Image caching
- **Gal** - Image saving/download
- **Pixabay API** - Image data source

---
The main layers are:

Data Layer -  API models and Pixabay API communication
Repository Layer - Repository abstraction and implementation
BLoC Layer - Application state management
Presentation Layer - Screens and reusable UI widgets
Requirements
Flutter SDK
Dart SDK
Android Studio / VS Code
Android device or emulator
Setup & Run
1. Clone the repository
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd <YOUR_PROJECT_FOLDER>
2. Install dependencies
flutter pub get
3. Configure Pixabay API Key

The API key is passed using --dart-define and is not hardcoded in the source code.

Run the application with:

flutter run --dart-define=PIXABAY_API_KEY=YOUR_API_KEY

Replace YOUR_API_KEY with your Pixabay API key.

4. Run normally

If the API key is already configured through your development environment:

flutter run

For Android:

flutter run -d android

To check available devices:

flutter devices
Build APK

To generate a release APK:

flutter build apk --release --dart-define=PIXABAY_API_KEY=YOUR_API_KEY

The APK will be generated inside:

build/app/outputs/flutter-apk/app-release.apk
Assumptions
A valid Pixabay API key is required to load images.
Internet connectivity is required for fetching images.
Favorites are stored locally on the device.
The application is primarily tested on Android.
Limitations
Pixabay API availability and rate limits may affect image loading.
The application depends on an active internet connection for new images.
Download functionality depends on device storage and platform permissions.
The Pixabay API has a limit on the number of accessible results.
