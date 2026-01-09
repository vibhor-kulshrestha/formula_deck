# Architecture Documentation

## Overview

FormulaDeck follows a clean architecture pattern with clear separation of concerns:

- **Models**: Data structures
- **Services**: Business logic and external integrations
- **Providers**: State management (Riverpod)
- **Screens**: UI screens
- **Widgets**: Reusable UI components

## Data Flow

```
User Interaction
    ↓
Screen/Widget
    ↓
Provider (Riverpod)
    ↓
Service
    ↓
Model/Storage
```

## Key Components

### Models

- **Formula**: Represents a mathematical/physics formula
- **Variable**: Input/output variables for formulas
- **CalculatorConfig**: Configuration for calculator functionality
- **Category**: Formula categories

### Services

#### FormulaService
- Loads formulas from JSON assets
- Provides search and filtering functionality
- Caches formulas in memory

#### CalculatorService
- Evaluates formulas with given inputs
- Supports common mathematical operations
- Handles formula-specific calculations

#### HiveService
- Manages local storage (Hive)
- Bookmarks persistence
- Settings storage (dark mode, ads removed)

#### AuthService
- Google Sign-In integration
- Firebase Authentication
- Future: Bookmark sync across devices

#### AdsService
- AdMob integration
- Banner and native ad loading
- Ad display management

#### IAPService
- In-App Purchase handling
- Purchase verification
- Premium feature unlocking

### State Management (Riverpod)

- **formulasProvider**: All formulas
- **categoriesProvider**: Available categories
- **searchQueryProvider**: Current search query
- **selectedCategoryProvider**: Selected category filter
- **filteredFormulasProvider**: Filtered formulas based on search/category
- **bookmarkedIdsProvider**: Set of bookmarked formula IDs
- **bookmarkedFormulasProvider**: List of bookmarked formulas
- **darkModeProvider**: Dark mode state
- **adsRemovedProvider**: Ads removed status

### Navigation

Uses GoRouter for declarative routing:
- `/` - Home screen
- `/formula/:id` - Formula detail screen
- `/bookmarks` - Bookmarks screen
- `/settings` - Settings screen

## Design Patterns

### Provider Pattern
- Riverpod providers for state management
- Separation of UI and business logic

### Repository Pattern
- Services act as repositories
- Abstract data access

### Singleton Pattern
- Services are static classes
- Single instance throughout app lifecycle

## Error Handling

- Try-catch blocks in async operations
- Fallback UI for errors
- User-friendly error messages

## Performance Optimizations

- Formula caching in memory
- Lazy loading of formulas
- Efficient list rendering
- Ad loading optimization

## Security Considerations

- Local storage for sensitive data
- Secure IAP verification
- Firebase security rules (for future sync)

## Future Enhancements

- Cloud bookmark sync
- Formula sharing
- Custom formula creation
- Exam mode
- Study reminders
- Formula history

