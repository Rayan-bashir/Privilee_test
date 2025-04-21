## 🏗 Project Architecture

This Flutter project follows the **Clean Architecture** pattern to ensure a clean separation of
concerns, improved testability, and scalability. Each feature is modularized and includes its own
set of layers. The domain layer contains business logic and repository contracts that are shared
between features.

```
lib/
│
├── core/                     # Shared classes (error handling, constants, services)
│   └── constants/           # App constants
│   └── services/            # App services
│   └── di/                   # Dependency injection
├── features/                 # Feature-based separation
│   ├── common/              # Shared UI components
│   └── venues/               # Example feature
│       ├── data/             # Models, data sources, repository implementations
│       ├── domain/           # Entities, repository contracts, use cases
│       ├── presentation/     # UI layer (screens, widgets, Bloc)
│
├── main.dart                 # App bootstrap and injection entry point
```

## 🧠 State Management

State management is handled using [`flutter_bloc`](https://pub.dev/packages/flutter_bloc), allowing
a clear separation between the UI and business logic. This approach ensures predictable state
transitions and facilitates testing.

## 🔗 Routing

Routing is implemented using [`go_router`](https://pub.dev/packages/go_router), a declarative and
flexible routing library recommended by the Flutter team. It supports deep linking, route guards,
and nested navigation.

## ✨ Features

- **Venue List:** Displays a list of venues with filtering capabilities.
- **Venue Details:** Shows detailed information about a selected venue, including a map view.

## 🧪 Testing Approach

The project includes examples for all major test types:

- **Unit Tests**
- **Widget Tests**
- **Integration Tests**

To run the integration test:

```bash
flutter drive \
  --driver=test/test_driver/integration_test.dart \
  --target=test/integration_test/filter_integration_test.dart
```

To test deep links on Android:

```bash
adb shell am start -a android.intent.action.VIEW -d "privilee://venue?name=COVEBEACH" com.example.new_project

```

## 🚀 How to Run

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

