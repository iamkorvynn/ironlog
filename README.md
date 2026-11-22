# IronLog

A local-only gym and workout tracker built with Flutter. Log workouts, chase
personal records, and watch your strength grow — no account, no cloud, no
ads. Everything lives on your device.

## Features

### Track workouts
- **Exercise library** — 12 built-in exercises (Bench Press, Squat, Deadlift,
  Overhead Press, Barbell Row, Pull-Up, Dips, Bicep Curl, and more), plus
  your own custom exercises, grouped by muscle group.
- **Workout logging** — start a workout, add exercises, and log every set
  with reps and weight. Edit or delete sets as you go.
- **Active workout screen** — your current session stays front and centre
  until you finish it.

### See progress
- **Personal records** — IronLog detects a new PR automatically and shows a
  badge for it, with an estimated 1RM for every lift.
- **Stats** — weekly training volume, workout streaks, and per-muscle-group
  breakdowns, with charts for volume over time.
- **Dashboard** — your latest workouts, current streak, and this week's
  volume at a glance.

### Train smarter
- **Rest timer** — start a timer between sets with 30/60/90/120-second
  presets, with a notification when time is up.
- **kg / lbs** — switch units any time; all weights convert.
- **Export & clear** — export your data as JSON, or wipe everything from
  Settings.

## Privacy

IronLog is local-first by design:

- All data is stored in a SQLite database on your device.
- No account, no sign-in, no server, no analytics.
- The app works fully offline. The only permission it requests is to post
  rest-timer notifications.

## Getting started

Prerequisites: [Flutter 3.50+](https://docs.flutter.dev/get-started/install)
(Dart 3.14+) and the Android SDK for the APK build.

```bash
git clone https://github.com/iamkorvynn/ironlog.git
cd ironlog
flutter pub get
flutter run
```

### Run the tests

```bash
flutter test
```

### Build the release APK

```bash
flutter build apk --release
# output: build/app/outputs/flutter-apk/app-release.apk
```

## Project structure

```text
lib/
├── main.dart               # App entry point
├── models/                 # Exercise, Workout, WorkoutSet, PersonalRecord, ...
├── screens/                # Dashboard, Exercises, Active Workout, Stats, Settings
├── services/               # SQLite database, stats, PR detection, rest timer,
│                           # notifications, settings
├── utils/                  # Constants (incl. the built-in exercise list), helpers
└── widgets/                # Reusable cards, charts, badges, dialogs
test/                       # Unit, service, and widget tests mirroring lib/
```

## Tech stack

- **Flutter** + Dart — UI and app logic
- **sqflite** — local SQLite storage
- **flutter_local_notifications** — rest-timer alerts

## Quality

- `flutter analyze`: 0 issues
- `flutter test`: 422 tests passing

## License

MIT — see [LICENSE](LICENSE).
