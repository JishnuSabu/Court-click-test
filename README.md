# CourtClick - Flutter Developer Machine Test (Movie Discovery App)

A production-quality, 7-screen Netflix-style Movie Discovery Application built with Flutter, implementing **Clean Architecture**, **BLoC / Cubit** state management, **Dio** networking client, and live data integration with **TheMovieDB (TMDB) REST API**.

---

## 📱 Features & Screen Breakdown

The application features 7 pixel-perfect screens adhering to the Figma design:

| Screen | Data Source | Description |
|---|---|---|
| **1. Logo Splash** | `MOCK` | Animated Netflix logo transition screen leading to Profile Selection. |
| **2. Profile Switcher** | `MOCK` | "Who's Watching?" profile grid (Emenalo, Onyeka, Thelma, Kids, Add Profile). |
| **3. Dashboard / Home** | `API (TMDB)` | Featured Hero Banner, Previews rail, Continue Watching, Popular, Trending Now, Top 10, My List. Pull-to-refresh & shimmer loaders. |
| **4. Search** | `API (TMDB)` | Debounced (~400ms) live TMDB query search. Default "Top Searches" view, live query results grid, play icons, empty & error states. |
| **5. Coming Soon** | `API (TMDB)` | Upcoming movies feed from TMDB, Notifications section, release date badges, descriptions, genre pills, Remind Me & Share buttons. |
| **6. Downloads** | `MOCK` | "Smart Downloads" toggle header, "Introducing Downloads For You" graphic illustration, SET UP button, and browsing button. |
| **7. More & Profile Settings** | `MOCK` | Profile header bar, Manage Profiles, Referral link box with "Copy Link" toast, social share icons, My List, App Settings, Account, Sign Out, & Light/Dark Theme toggle. |
| **+ Details Modal** | `API / Interactive` | Interactive movie details bottom sheet with backdrop, play/download actions, rating, release year, overview summary, and genre tags. |

---

## 🛠️ Tech Stack & Packages Used

- **Framework**: Flutter (Dart with Sound Null Safety)
- **State Management**: `flutter_bloc` & `equatable` (Strict BLoC / Cubit pattern; no `setState` for business logic)
- **Networking**: `dio` (Centralized client, base URL `https://api.themoviedb.org/3`, query interceptor, timeout & exception handling)
- **Dependency Injection**: `get_it` service locator
- **Caching & Media**: `cached_network_image` with shimmer placeholders & fallback widgets
- **Loading Skeletons**: `shimmer` package for smooth skeleton loading UI
- **Typography & Theme**: `google_fonts` (Montserrat), custom Netflix Dark aesthetic with toggleable Light Mode via `ThemeCubit`.
- **Search Optimization**: `rxdart` (400ms debounce transformer)
- **Unit Testing**: `bloc_test` & `mocktail`

---

## 🏗️ Clean Architecture Structure

```
lib/
├── core/
│   ├── config/             # EnvConfig (Base URL, Image URLs, API Key getter)
│   ├── di/                 # GetIt Injection Container
│   ├── network/            # Centralized Dio Client & Error Handler
│   └── theme/              # AppTheme (Dark & Light) & ThemeCubit
├── features/
│   ├── downloads/          # Downloads Screen (Mock)
│   ├── movie/
│   │   ├── data/
│   │   │   ├── datasources/   # TmdbApiService (REST Dio calls)
│   │   │   ├── models/        # MovieModel & MovieResponse JSON parsing
│   │   │   └── repositories/  # MovieRepositoryImpl
│   │   ├── domain/
│   │   │   └── repositories/  # MovieRepository interface
│   │   └── presentation/
│   │       ├── bloc/          # HomeBloc, SearchBloc, ComingSoonBloc
│   │       ├── screens/       # HomeScreen, SearchScreen, ComingSoonScreen
│   │       └── widgets/       # ShimmerLoading & MovieDetailsSheet
│   ├── navigation/         # MainShellScreen (IndexedStack Bottom Navigation)
│   ├── profile/            # ProfileSelectionScreen & MoreScreen (Mock)
│   └── splash/             # SplashScreen (Animated Logo)
└── main.dart               # App Root Entry Point
```

---

## 🚀 Getting Started

### 1. Prerequisites
- Flutter SDK `^3.12.0` or higher
- Android Studio / Xcode / VS Code

### 2. Installation
Clone the repository and fetch dependencies:
```bash
git clone https://github.com/your-username/court_click_task.git
cd court_click_task
flutter pub get
```

### 3. Running the App
You can run the app directly using the built-in fallback TMDB API key or supply your own TMDB API key via `--dart-define`:

```bash
# Option A: Run with default fallback key
flutter run

# Option B: Run with custom TMDB API Key
flutter run --dart-define=TMDB_API_KEY=YOUR_TMDB_API_KEY
```

---

## 🧪 Running Unit Tests

Execute unit and widget tests:
```bash
flutter test
```

All BLoC tests (`HomeBloc`, `SearchBloc`, widget test) will run and verify state transitions (`Initial` -> `Loading` -> `Loaded` / `Error`).

---

## 📦 Building Android APK

Build a debug/release APK for Android:
```bash
flutter build apk --debug
```

Output location:
`build/app/outputs/flutter-apk/app-debug.apk`
