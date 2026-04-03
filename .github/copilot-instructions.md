---
description: "Flutter mobile development guidelines for Apartum. Use when: building features, creating widgets, implementing state management, or writing any Dart code. Enforces Bloc-only pattern, feature-first architecture, specific tech stack (Dio, go_router, flutter_screenutil), premium design aesthetics, and mobile best practices."
---

# Apartum – Flutter Development Guidelines

## Project Architecture

Your application follows **feature-first clean architecture**. Always structure code as:

```
lib/
├── main.dart
├── core/
│   ├── router.dart           # go_router configuration
│   ├── global_data/          # App-level constants, enums
│   ├── global_widget/        # Shared UI components
│   ├── network/              # API client setup (Dio)
│   └── theme/                # ThemeData, colors, typography
└── features/
    ├── auth/
    ├── homepage/
    ├── konseling/
    ├── onboarding/
    ├── profile/
    ├── riwayat_catatan/
    └── splash/
```

Each feature follows this structure:

```
feature_name/
├── presentation/
│   ├── bloc/                 # BLoC classes only (no Cubit)
│   │   ├── feature_event.dart
│   │   ├── feature_state.dart
│   │   └── feature_bloc.dart
│   ├── pages/                # Full-screen widgets
│   └── widgets/              # Reusable feature components
├── domain/
│   ├── entities/             # Pure Dart models (immutable)
│   ├── repositories/         # Abstract repository interfaces
│   └── usecases/             # Business logic, single responsibility
└── data/
    ├── models/               # JSON-serializable DTOs
    ├── datasources/          # Remote (Dio) & local (hive/isar/shared_preferences)
    └── repositories/         # Concrete implementations
```

**Key Rules:**
- Every screen/feature with state management **must** use **BLoC only** (not Cubit)
- Stateless widgets for presentational components with no state changes
- BLoCs manage business logic; repositories handle data access
- Use `@immutable` and `const` constructors for events/states
- Name features in **English by default**. Use **Indonesian naming only if explicitly requested by user** for specific features.

---

## Technology Stack

| Category | Technology | Purpose |
|----------|-----------|---------|
| **State Management** | `flutter_bloc` | BLoC pattern for all stateful features (no Cubit) |
| **Networking** | `dio` | HTTP client with interceptors, base options, error handling |
| **API Models** | `json_serializable`, `build_runner` | Type-safe JSON parsing & serialization |
| **Routing** | `go_router` | Declarative, robust routing with deep linking support |
| **Local Storage (Simple)** | `shared_preferences` | Key-value store for settings, session flags, tokens |
| **Local Storage (Complex)** | `hive` | Structured, offline-first database for complex data |
| **Responsive Design** | `flutter_screenutil` | Adaptive scaling across screen sizes (`.w`, `.h`, `.sp`, `.r`) |
| **UI/UX Polish** | `skeletonizer` | Shimmer loading states for perceived instant load |
| **Modern Typography** | `google_fonts` | Premium typeface alternatives to system defaults |
| **Theme System** | `ColorScheme.fromSeed` or custom palettes | Dark/Light mode support, Material Design 3 compliance |


---

## State Management: BLoC Only

### Pattern
```dart
// ✅ CORRECT: Use BLoC with Events and States
class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  FeatureBloc(this.repository) : super(const FeatureInitial()) {
    on<FetchDataEvent>(_onFetchData);
  }

  Future<void> _onFetchData(FetchDataEvent event, Emitter<FeatureState> emit) async {
    emit(const FeatureLoading());
    try {
      final data = await repository.fetchData();
      emit(FeatureSuccess(data));
    } catch (e) {
      emit(FeatureError(e.toString()));
    }
  }
}
```

```dart
// ❌ INCORRECT: Do NOT use Cubit
class FeatureCubit extends Cubit<FeatureState> { ... } // FORBIDDEN
```

### Rules
- All events and states must be **immutable** (`@immutable` annotation, `const` constructors)
- Events represent user actions or external events
- States represent the UI state (loading, success, error, empty)
- BLoCs should not directly access UI layer; always emit states
- Use `BlocProvider`, `BlocListener`, `BlocBuilder` for integration

---

## Design Aesthetics & Implementation

### 1. Premium Visual Design
- **Never** ship default boilerplate themes
- Set up `ThemeData` with `ColorScheme.fromSeed()` or custom, cohesive color palettes
- Implement **Dark Mode and Light Mode** support automatically
- Use `google_fonts` for modern typography instead of system defaults
- Avoid placeholder images; use `generate_image` tools or high-quality network imagery

### 2. Dynamic, Alive UI
- Use Flutter's animation library: `AnimatedContainer`, `Hero`, implicit animations
- Target **60/120 fps** for smooth micro-interactions
- Use `InkWell` for Material ripple effects; `GestureDetector` for custom touch
- Provide visual feedback for all async operations

### 3. Native Feel
- **iOS**: Enable swipe-to-go-back, adaptive indicators (`CircularProgressIndicator.adaptive()`)
- **Android**: Physical back button behavior, platform-accurate scrolling physics
- Both: Use `SafeArea` to prevent UI clipping

### 4. Loading States
- **Prioritize Skeletonizer (shimmer effects)** over spinners for content-heavy screens
- Use spinners only for small, focused actions
- Never leave users without visual feedback during async operations

---

## Implementation Workflow

### 1. Plan & Understand
- Clarify user requirements and target platforms (iOS, Android, or both)
- Outline features, BLoC structure, and data flow
- Sketch screens and navigation

### 2. Build Foundation
- Set up `main.dart` and root `MaterialApp` / `CupertinoApp`
- Wrap root with `ScreenUtilInit` for responsive scaling
- Implement core theme system, design tokens, typography
- Configure `go_router` and dependency injection (GetIt, Riverpod, or similar)

### 3. Create Reusable Components
- Build custom, reusable widgets in `global_widget/` or feature-scoped `widgets/`
- Extract complex layouts into smaller widget classes, not nested helpers
- Use `const` constructors wherever possible

### 4. Assemble Screens
- Compose screens with `Scaffold`, `Slivers`, custom widgets
- Integrate state management: `BlocProvider`, `BlocBuilder`, `BlocListener`
- Implement proper loading/error/empty states

### 5. Polish & Optimize
- Implement Skeletonizer for data-fetching phases
- Review animations and transitions for smoothness
- Test on multiple screen sizes and devices

---

## Mobile Best Practices

### Performance
- Use `const` constructors everywhere to prevent unnecessary rebuilds
- Avoid heavy computation in `build()` methods
- Profile with DevTools when optimization is needed

### Responsiveness
- Use **flutter_screenutil** for all dimensions: `.w`, `.h`, `.sp`, `.r`
- Use `SafeArea` on all screens
- Use `LayoutBuilder` for major structural shifts (phone vs. tablet)

### State Handling
- Always provide loading states during async operations
- Use Skeletonizer for content-heavy screens
- Handle success, error, and empty states explicitly
- Never show a blank screen while fetching data

### Accessibility (if needed)
- Use `Semantics` for screen reader support
- Ensure interactive touch targets are at least 48x48 logical pixels
- Test with accessibility scanner tools

---

## Critical Reminders

> **⚠️ AESTHETICS AND SMOOTHNESS ARE ESSENTIAL.** If an app looks basic, lacks native interactions, or suffers from UI jank, the implementation has failed.

- **No Cubit**: Bloc-only pattern, strictly enforced
- **Premium Design**: Default themes are unacceptable; invest in custom design systems
- **No Spinners for Load**: Use Skeletonizer unless it's a small, focused action
- **Responsive by Default**: Every dimension must use `flutter_screenutil` utilities
- **Indonesian Naming**: Only when explicitly requested for specific features; default to English

---

## Quick Reference Checklist

When starting a new feature, ensure:

- [ ] Feature folder structure created under `lib/features/feature_name/`
- [ ] BLoC created (with Events, States, Bloc class) – no Cubit
- [ ] Domain entities and use cases implemented
- [ ] Data models with `@JsonSerializable()` and `fromJson`/`toJson`
- [ ] Repository interface in domain, implementation in data
- [ ] Theme tokens applied (colors, typography, spacing)
- [ ] Loading states visible with Skeletonizer or shimmer
- [ ] Error states handled with user-friendly messages
- [ ] `go_router` route added to `core/router.dart`
- [ ] Responsive design with `flutter_screenutil` (`.w`, `.h`, `.sp`)
- [ ] `const` constructors used throughout
- [ ] Animations smooth and 60+ fps
