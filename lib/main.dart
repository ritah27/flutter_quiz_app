import 'package:flutter/material.dart';

void main() {
  runApp(const Quiz());
}

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Questions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizHomePage(),
    );
  }
}

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  QuizHomePageState createState() => QuizHomePageState();
}

class QuizHomePageState extends State<QuizHomePage> {
  int currentQuestionIndex = 0;
  int totalScore = 0;

  List<Map<String, dynamic>> questions = [
    {
      'question': 'Mention one example of a cover crop.',
      'options': [
        'Maize',
        'Cowpeas',
        'Mango'
      ],
      'correctAnswer':1,
    },
    {
      'question': 'Name the body organ protected by the skull.',
      'options': ['The brain ', 'liver', 'Eyes'],
      'correctAnswer':0,
    },
    {
      'question': 'Mention any one example of a flying mammal.',
      'options': ['Bat', 'Hen', 'Cockroach'],
      'correctAnswer':0,
    },
   {
      'question': 'Name any crop pest.',
      'options': ['Snake', 'Rat', 'Cockroach'],
      'correctAnswer':1,
    },

  ];

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex]['correctAnswer']) {
      setState(() {
        totalScore++;
      });
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:const Text('Quiz Finished'),
            content: Text('Your score: $totalScore out of ${questions.length}'),
            actions: [
              TextButton(
                child:const Text('Restart Quiz'),
                onPressed: () {
                  setState(() {
                    currentQuestionIndex = 0;
                    totalScore = 0;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}',
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          const  SizedBox(height: 16.0),
            Text(
              questions[currentQuestionIndex]['question'],
              style: const TextStyle(fontSize: 18.0),
            ),
         const   SizedBox(height: 16.0),
            ...List.generate(
              questions[currentQuestionIndex]['options'].length,
              (index) => ElevatedButton(
                child: Text(questions[currentQuestionIndex]['options'][index]),
                onPressed: () => checkAnswer(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}