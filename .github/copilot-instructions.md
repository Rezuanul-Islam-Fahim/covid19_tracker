# COVID-19 Tracker - AI Coding Instructions

## Project Overview
Flutter 3.5+ cross-platform COVID-19 statistics tracker. Uses disease.sh API for real-time pandemic data across Android, iOS, Web, Windows, macOS, and Linux.

## Architecture Pattern

### Three-Layer Structure
- **Presentation** (`lib/screens/`, `lib/components/`): StatefulWidget-based screens with direct state management
- **Domain** (`lib/models/`): Plain Dart classes for data models (`CovidInfoAll`, `CovidInfoCountry`)
- **Data** (`lib/models/covid_api_handler.dart`): Single `CovidHandler` class with static methods for all API calls

### State Management
**No state management library** - uses setState() with StatefulWidgets. All screens manage their own loading states:
```dart
bool isLoading = true;
Future<void> loadCovidData() async {
  // Fetch data
  setState(() {});
}
```

### Navigation Pattern
Named routes defined in `main.dart`. Use `routeName` static constants:
```dart
Navigator.pushNamed(context, AllCountryScreen.routeName);
// For routes with arguments (like CountryScreen):
Navigator.pushNamed(context, CountryScreen.routeName, arguments: countryName);
```

Drawer navigation uses `pushNamedAndRemoveUntil` to maintain Home as stack base (see `lib/components/drawer.dart`).

## API Integration

### disease.sh COVID-19 API
All endpoints use `CovidHandler.getCovidData()` static method:
```dart
// Global stats → returns CovidInfoAll
await CovidHandler.getCovidData(Uri.parse('https://disease.sh/v3/covid-19/all'));

// All countries → returns List<CovidInfoCountry>
await CovidHandler.getCovidData(Uri.parse('https://disease.sh/v3/covid-19/countries'));

// Single country → returns CovidInfoCountry
await CovidHandler.getCovidData(Uri.parse('https://disease.sh/v3/covid-19/countries/usa'));

// Top 5 sorted → returns List<CovidInfoCountry>
await CovidHandler.getCovidData(
  Uri.parse('https://disease.sh/v3/covid-19/countries?sort=cases'),
  fetchLength: 5
);
```

**Data parsing logic**: `CovidHandler.parsedJSON()` auto-detects response type (List vs single object) and returns appropriate model.

## Local Persistence
Uses `shared_preferences` for country selection only:
```dart
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString('countryName', countryName); // Stores user's selected country
```

## Theme & Styling

### Global Constants (`lib/constant.dart`)
- Primary color: `kPrimaryColor` (#0D8E53 green)
- Text hierarchy: `kTextColor`, `kTextMediumColor`, `kTextLightColor`
- Data colors: `casesColor`, `deathsColor`, `recoveredColor`, `newCasesColor`

### Theme Configuration (`lib/theme.dart`)
Centralized `appTheme` getter defines all Material components. Use theme text styles:
```dart
Text('Title', style: Theme.of(context).textTheme.displayMedium) // 19px bold
Text('Subtitle', style: Theme.of(context).textTheme.displaySmall) // 18px semi-bold
Text('Body', style: Theme.of(context).textTheme.headlineMedium) // 15px semi-bold
```

## Component Patterns

### Pull-to-Refresh
Standard pattern across screens - reset state to initial values, then reload:
```dart
Future<void> pullToRefresh() async {
  setState(() {
    covidData = [];
    isLoading = true;
  });
  loadCovidData();
}
```

### Search Implementation
Custom `SearchDelegate` in `lib/components/search.dart`:
- `suggestionList`: Filters countries by name prefix (case-insensitive)
- `buildResults()`: Shows full country detail panel or suggestions
- `buildSuggestions()`: Shows filtered country list while typing

### Custom Icons
SVG icons in `assets/icons/` rendered with `flutter_svg`:
```dart
SvgPicture.asset(
  'assets/icons/menu.svg',
  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
)
```

## Build & Deployment

### Local Development
```bash
flutter pub get                    # Install dependencies
flutter run                        # Run on connected device/emulator
flutter run -d chrome              # Run web version
flutter build apk --release        # Build Android APK
```

### CI/CD Pipeline
`.github/workflows/build-and-deploy-appetize.yml` automates:
1. Gradle & Flutter dependency caching (3x speedup)
2. APK build with version from `pubspec.yaml`
3. Appetize.io deployment for browser testing
4. PR comments with live demo links

**Required secrets**: `APPETIZE_API_TOKEN`, `APPETIZE_PUBLIC_KEY` (after first deploy)

## Code Conventions

### File Organization
- Screens have dedicated folders if they have sub-components (e.g., `home_screen/`)
- Reusable components in top-level `components/`
- Models contain both data classes and API logic (not separated)

### Naming
- Data models: `CovidInfo*` prefix
- Screens: `*Screen` suffix with static `routeName`
- Components: Descriptive names without suffix

### Common Patterns
- API calls in `initState()` lifecycle method
- Loading states with ternary: `isLoading ? loader(context) : ActualContent`
- Country flag images from API: `Image.network(covidData.flag!)`
- Null-safety: Models use nullable fields (`String?`, `int?`) with `!` assertions when rendering

## Testing Considerations
- No test files present - add tests in `test/` directory
- API calls are static methods (consider mocking strategy)
- UI components tightly coupled with data models (consider builder pattern for testability)

## Common Tasks

**Add new screen**: 
1. Create in `lib/screens/`, extend StatefulWidget
2. Add `static const routeName` 
3. Register in `main.dart` routes map

**Add API endpoint**:
1. Use existing `CovidHandler.getCovidData()` - no changes needed if response matches existing models
2. Create new model in `lib/models/` if response structure differs
3. Update `CovidHandler.parsedJSON()` if new response type

**Update theme**:
Modify `lib/theme.dart` `appTheme` getter - changes apply globally via `Theme.of(context)` calls
