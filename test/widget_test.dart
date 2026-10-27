import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/main.dart';

void main() {
  testWidgets('answers advance through ten questions, score, and restart', (tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1;
    await tester.pumpWidget(const QuizApp());

    for (var i = 0; i < questions.length; i++) {
      expect(find.text('Question ${i + 1} of 10'), findsOneWidget);
      await tester.tap(find.text(questions[i].options[questions[i].answerIndex]));
      await tester.pump();
      expect(find.text('Correct! Great job.'), findsOneWidget);
      await tester.tap(find.text(i == 9 ? 'See results' : 'Next question'));
      await tester.pump();
    }

    expect(find.text('You scored 10 out of 10'), findsOneWidget);
    await tester.tap(find.text('Restart quiz'));
    await tester.pump();
    expect(find.text('Question 1 of 10'), findsOneWidget);

    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
}
