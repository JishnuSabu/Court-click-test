# CourtClick - Flutter Movie Discovery App

A production-quality, 7-screen Netflix-style Movie Discovery Application built with Flutter, featuring **BLoC / Cubit** state management, **Dio** network client, **GetIt** dependency injection, and live data integration with **TheMovieDB (TMDB) REST API**.

---

## 📱 Features & Screen Breakdown

The application features 7 pixel-perfect screens adhering to modern UI/UX principles and dark theme aesthetics:

| Screen | Data Source | Description |
|---|---|---|
| **1. Logo Splash** | `MOCK` | Netflix logo transition screen leading to Profile Selection. |
| **2. Profile Switcher** | `MOCK` | "Who's Watching?" profile grid (Emenalo, Onyeka, Thelma, Kids, Add Profile). |
| **3. Home Dashboard** | `API (TMDB)` | Featured Hero Banner, Previews rail, Continue Watching, Popular Movies, Trending Now, Top 10, My List. Handles loading, error & data states. |
| **4. Search Screen** | `API (TMDB)` | Persistent search bar with live debounced TMDB search results. Handles empty, loading, no-results, and error states. |
| **5. Coming Soon** | `API (TMDB)` | Upcoming movies feed from TMDB, Notifications section, release date badges, descriptions, genre pills, Remind Me & Share actions. |
| **6. Downloads** | `MOCK` | "Smart Downloads" toggle header, "Introducing Downloads For You" illustration, SET UP button, and browsing button. |
| **7. More & Profile Settings** | `MOCK` | Profile header bar, Manage Profiles, Referral link box with "Copy Link" toast notification, social share icons (WhatsApp, Facebook, Gmail), My List, App Settings, Account, & Sign Out. |

---

## 🛠️ Packages Used

- **`flutter_bloc` / `bloc`**: Predictable BLoC & Cubit state management pattern without `setState`.
- **`dio`**: High-performance HTTP network client with custom headers, query parameter interceptors, timeout configurations, and automatic retry logic.
- **`get_it`**: Dependency injection service locator container.
- **`flutter_svg`**: Renders scalable vector graphics (SVGs) for social share buttons, badges, and icons.
- **`cached_network_image`**: Network image caching with fallback placeholder widgets.
- **`rxdart`**: Stream transformers for input debouncing in live query search.
- **`bloc_test` & `mocktail`**: BLoC unit testing and service mocking.

---

## 🏗️ Architecture Overview

The app follows a Clean Layered Architecture with BLoC state management and Dependency Injection:

```
lib/
├── bloc/                   # BLoC & Cubit State Management
│   ├── home/               # HomeBloc, HomeEvent, HomeState
│   ├── search/             # SearchBloc, SearchEvent, SearchState
│   └── nav/                # NavCubit (Tab index switcher)
├── core/                   # Core Infrastructure & Exception Handling
│   └── network/            # Endpoints, DioClient, DioExceptions
├── models/                 # Data Models & JSON Serialization
│   ├── popular_movies_model.dart
│   ├── trending_movies_model.dart
│   ├── top_rated_movie_model.dart
│   └── up_coming_movie_model.dart
├── screens/                # UI Screens
│   ├── splash_screen.dart
│   ├── profile_selection_screen.dart
│   ├── main_nav_screen.dart
│   ├── home_screen.dart
│   ├── search_screen.dart
│   ├── coming_soon_screen.dart
│   ├── downloads_screen.dart
│   ├── more_screen.dart
│   └── widget/             # Refactored Reusable Modular UI Components
│       ├── custom_bottom_nav_bar.dart
│       ├── cm_horizontal_list_view_widget.dart
│       ├── custom_movie_image.dart
│       ├── search_list_item.dart
│       ├── notification_item.dart
│       ├── social_share_icon.dart
│       └── more_list_option.dart
├── services/               # API & Remote Data Services
│   ├── api_service.dart
│   └── dio_client.dart
├── utils/                  # App Constants, Colors, Router, DI Container
│   ├── constants.dart
│   ├── app_router.dart
│   └── dependency_injection.dart
└── main.dart               # Main App Entry Point
```

### Key Architectural Highlights:
- **Zero `setState`**: UI components consume BLoC/Cubit streams using `BlocBuilder` and `ValueListenableBuilder`.
- **Dependency Injection**: Centralized in `lib/utils/dependency_injection.dart` using `GetIt`.
- **Network Resilience**: `DioClient` automatically attaches the TMDB API key to outgoing requests and handles network error codes cleanly.

---

## 🔌 API-Driven vs. Mock Breakdown

### API-Driven Components (TheMovieDB REST API)
- **`HomeScreen`**: Fetches live trending movies (`/trending/all/week`), popular movies (`/movie/popular`), now playing (`/movie/now_playing`), and top rated movies (`/movie/top_rated`).
- **`SearchScreen`**: Fetches live search results from TMDB (`/search/movie`) debounced as the user types.
- **`ComingSoonScreen`**: Fetches upcoming movie releases (`/movie/upcoming`) with backdrop posters and release dates.

### Mock-Driven Components
- **`SplashScreen`**: Static animated Netflix logo branding.
- **`ProfileSelectionScreen`**: Avatar switcher with predefined profile names and add profile option.
- **`DownloadsScreen`**: Static illustration, feature announcement, and downloads setup layout.
- **`MoreScreen`**: Static account setting list options, referral link box, and social share buttons.

---

## 🚀 Setup Steps & How to Add API Key

### 1. Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.12.0` or higher)
- Android Studio / Xcode / VS Code with Flutter extension

### 2. Getting Started
Clone the repository and install dependencies:
```bash
git clone https://github.com/JishnuSabu/Court-click-test.git
cd Court-click-test
flutter pub get
```

### 3. Adding Your TMDB API Key
By default, the application includes a working TMDB API key. To use your own API key:
1. Get an API key from [TheMovieDB (TMDB)](https://www.themoviedb.org/settings/api).
2. Open `lib/utils/constants.dart`.
3. Update `_defaultApiKey` in `AppConstants`:
   ```dart
   class AppConstants {
     static const String baseUrl = 'https://api.themoviedb.org/3';
     static const String _defaultApiKey = 'YOUR_TMDB_API_KEY';
     // ...
   }
   ```

### 4. Running the App
Run the app on a connected emulator or physical device:
```bash
flutter run
```

### 5. Running Unit & Widget Tests
Execute the automated test suite:
```bash
flutter test
```

### 6. Building APK
Generate a release APK:
```bash
flutter build apk --release
```
Output location: `build/app/outputs/flutter-apk/app-release.apk`

