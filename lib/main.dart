import 'package:flutter/material.dart';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quick Quiz',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBE123C)), useMaterial3: true),
        home: const QuizScreen(),
      );
}

class Question {
  const Question(this.prompt, this.options, this.answerIndex);
  final String prompt;
  final List<String> options;
  final int answerIndex;
}

const questions = <Question>[
  Question('Which widget arranges children vertically?', ['Row', 'Column', 'Stack', 'Wrap'], 1),
  Question('Which language is used to write Flutter apps?', ['Dart', 'Kotlin only', 'Swift only', 'Ruby'], 0),
  Question('Which widget creates a tappable Material button?', ['Text', 'Padding', 'FilledButton', 'Divider'], 2),
  Question('What does setState do?', ['Saves a file', 'Requests a UI rebuild', 'Navigates back', 'Creates a route'], 1),
  Question('Which widget can scroll through a long list efficiently?', ['ListView.builder', 'SizedBox', 'Center', 'Icon'], 0),
  Question('Which property gives a widget a stable identity in a list?', ['Key', 'Color', 'Padding', 'Width'], 0),
  Question('What is the root widget for a Material app?', ['MaterialApp', 'MaterialButton', 'AppBar', 'ScaffoldBody'], 0),
  Question('Which widget adds space around a child?', ['Padding', 'Text', 'Icon', 'SnackBar'], 0),
  Question('Which widget provides a page structure with app bar and body?', ['Scaffold', 'Container', 'Row', 'Divider'], 0),
  Question('How do you move to a new screen with Navigator?', ['Navigator.push', 'Navigator.paint', 'Navigator.build', 'Navigator.remove'], 0),
];

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _index = 0;
  int _score = 0;
  int? _selected;
  bool get _finished => _index >= questions.length;
  String get _explanation => [
    'Column places its children from top to bottom; Row places them side by side.',
    'Flutter apps are written in Dart, the language maintained for Flutter development.',
    'FilledButton is a Material button designed for a prominent filled action.',
    'setState tells Flutter that this State changed and its UI should be rebuilt.',
    'ListView.builder creates list items on demand, which is useful for longer lists.',
    'A Key helps Flutter identify a widget when items move or change in a list.',
    'MaterialApp sets up the app-level Material design structure and navigation.',
    'Padding adds space around its child without changing the child itself.',
    'Scaffold provides common page structure such as an app bar and body.',
    'Navigator.push adds a route to the navigation stack to show a new screen.',
  ][_index];

  void _answer(int option) {
    if (_selected != null) return;
    setState(() {
      _selected = option;
      if (option == questions[_index].answerIndex) _score++;
    });
  }

  void _next() => setState(() {
        _index++;
        _selected = null;
      });

  void _restart() => setState(() {
        _index = 0;
        _score = 0;
        _selected = null;
      });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Flutter Quick Quiz'), centerTitle: true),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _finished ? _results(context) : _questionView(context),
            ),
          ),
        ),
      );

  Widget _questionView(BuildContext context) {
    final question = questions[_index];
    final correct = _selected == question.answerIndex;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('Question ${_index + 1} of ${questions.length}', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 10),
      LinearProgressIndicator(value: (_index + 1) / questions.length, minHeight: 8, borderRadius: BorderRadius.circular(8)),
      const SizedBox(height: 28),
      Text(question.prompt, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 18),
      for (var i = 0; i < question.options.length; i++)
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: OutlinedButton(
            onPressed: _selected == null ? () => _answer(i) : null,
            style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16), alignment: Alignment.centerLeft),
            child: Row(children: [Expanded(child: Text(question.options[i])), if (_selected != null && i == question.answerIndex) const Icon(Icons.check_circle, color: Colors.green), if (_selected == i && !correct) const Icon(Icons.cancel, color: Colors.red)]),
          ),
        ),
      if (_selected != null) ...[
        const SizedBox(height: 8),
        Text(correct ? 'Correct! Great job.' : 'Not quite. The correct answer is ${question.options[question.answerIndex]}.', style: TextStyle(fontWeight: FontWeight.w600, color: correct ? Colors.green : Colors.red)),
        const SizedBox(height: 8),
        Text(_explanation, style: Theme.of(context).textTheme.bodyMedium),
        const Spacer(),
        FilledButton(onPressed: _next, child: Text(_index == questions.length - 1 ? 'See results' : 'Next question')),
      ] else
        const Spacer(),
    ]);
  }

  Widget _results(BuildContext context) => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.emoji_events_outlined, size: 72, color: Color(0xFFBE123C)),
        const SizedBox(height: 16),
        Text('Quiz complete!', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text('You scored $_score out of ${questions.length}', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(_score == questions.length ? 'Perfect score — excellent work!' : _score >= 7 ? 'Strong result — review any missed answers and try again.' : 'Keep practicing — a second round will help reinforce these Flutter basics.'),
        const SizedBox(height: 28),
        FilledButton.icon(onPressed: _restart, icon: const Icon(Icons.replay), label: const Text('Restart quiz')),
      ]);
}
