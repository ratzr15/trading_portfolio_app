# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Run Commands

```bash
# Install dependencies (run from project root)
flutter pub get

# Run the app
flutter run

# Run all tests
flutter test

# Run a single test file
flutter test test/src/presentation/portfolio_screen_widget_test.dart

# Run tests with coverage
flutter test --coverage

# Run golden tests (update goldens with --update-goldens flag)
flutter test --update-goldens

# Analyze code
flutter analyze

# Run tests for a specific package
cd packages/core/api_client && flutter test
cd packages/design/design_system && flutter test
```

## Architecture

This is a Flutter trading portfolio app using **Clean Architecture** with a layered structure:

### Main App (`lib/src/`)
- **data/**: Data sources and repository implementations
  - `data_source/`: Remote data sources (portfolio instruments, live market prices)
  - `repository/`: Repository implementations
  - `mappers/`: Remote-to-domain model mappers
- **domain/**: Business logic layer
  - `models/`: Domain models (PortfolioModel, PositionModel, BalanceModel)
  - `repository/`: Repository interfaces
  - `usecase/`: Use cases (GetUserPortfolioUseCase, ObserveRealTimePriceUseCase)
- **presentation/**: UI layer with BLoC pattern
  - `bloc/`: BLoC classes for state management
  - `components/`: Reusable UI components (price widget with its own BLoC)
  - `mapper/`: Domain-to-display model mappers
  - `models/`: Display models for UI
- **di/**: Dependency injection using Provider (`PortfolioScreenProvider`)

### Local Packages (`packages/`)
- **core/api_client**: HTTP client wrapper using Dio with connectivity handling
- **core/utils**: Utility classes (JSON utils, string utils, etc.)
- **design/design_system**: Design tokens (Dimens) and reusable components (CustomAppBar)

### Key Patterns
- **Provider** for dependency injection following inherited widget hierarchy
- **BLoC** (flutter_bloc) for state management in presentation layer
- **Mocktail** for mocking in tests
- **golden_toolkit** for golden/snapshot tests in design_system package

## Code Quality

The project enforces strict Dart type safety:
```yaml
strict-casts: true
strict-inference: true
strict-raw-types: true
```

Use `prefer_single_quotes: true` for string literals.

## Environment

- Flutter: 3.24.5
- Dart: 3.5.4
