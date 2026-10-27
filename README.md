# Quiz App

A ten-question Flutter quiz about Flutter and Dart basics. It shows progress, locks answers after a selection, gives correct/incorrect feedback, scores the attempt, and allows a full restart.

## Run

Open [DartPad](https://dartpad.dev/), choose Flutter, paste `lib/main.dart`, and press **Run**. For a local run, install Flutter, run `flutter create --platforms=web .` once, then run `flutter pub get` and `flutter run -d chrome`.

## Checklist

- Answer all ten questions, confirm progress and correct/incorrect feedback, and verify choices are disabled after an answer.
- Confirm the score matches the correct answers and the results screen appears at the end.
- Restart should return to question one with a cleared score and answer selection.
- Run `flutter test`; GitHub Actions analyzes, tests, builds, and publishes the web preview.
