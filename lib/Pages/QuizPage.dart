import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:html/parser.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Quiz> quizzes = [];
  int currentQuestionIndex = 0;
  int streak = 0;

  @override
  void initState() {
    super.initState();
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
    final int numberOfQuestions = 10; // Initial number of questions
    final int batchSize = 5;

    try {
      print('Fetching quizzes');

      final response = await http.get(Uri.parse(
          'https://opentdb.com/api.php?amount=$numberOfQuestions&category=18&difficulty=easy&type=multiple'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['response_code'] != 0) {
          print('Failed to load quizzes: ${data['response_message']}');
          return;
        }

        final List<dynamic> quizzesData = data['results'];

        setState(() {
          quizzes.addAll(quizzesData.map((json) => Quiz.fromJson(json)));
        });
      } else {
        print('Failed to load quizzes: ${response.statusCode}');
        return;
      }
    } catch (e, stackTrace) {
      print('Error fetching quizzes: $e');
      print('StackTrace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: currentQuestionIndex < quizzes.length
            ? QuizContentPage(
          quiz: quizzes[currentQuestionIndex],
          onNextQuestion: (isCorrect) {
            setState(() {
              if (isCorrect) {
                streak++;
              } else {
                // If the answer is incorrect, reset the streak
                streak = 0;
              }
              currentQuestionIndex++;
            });
          },
          streak: streak,
        )
            : Center(
          child: Text('Quiz Completed'),
        ),
      ),
    );
  }
}

class QuizContentPage extends StatefulWidget {
  final Quiz quiz;
  final Function(bool) onNextQuestion;
  int streak;

  QuizContentPage({
    Key? key,
    required this.quiz,
    required this.onNextQuestion,
    required this.streak,
  }) : super(key: key);

  @override
  _QuizContentPageState createState() => _QuizContentPageState();
}

class _QuizContentPageState extends State<QuizContentPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;
  String? selectedOption;
  bool isCorrect = false;
  bool choicesDisabled = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10.0, end: -10.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -10.0, end: 0.0), weight: 1),
    ]).animate(_animationController);

    _fadeInController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeInController,
        curve: Curves.easeIn,
      ),
    );

    _fadeInController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FadeTransition(
                opacity: _fadeInAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _fadeInController,
                      curve: Curves.easeIn,
                    ),
                  ),
                  child: Text(
                    widget.streak.toString(),
                    style: TextStyle(fontSize: 30, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              FadeTransition(
                opacity: _fadeInAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _fadeInController,
                      curve: Curves.easeIn,
                    ),
                  ),
                  child: Text(
                    widget.quiz.question,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.quiz.options.map((option) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: AnimatedBuilder(
                      animation: _shakeAnimation,
                      builder: (context, child) => Transform.translate(
                        offset: Offset(_shakeAnimation.value, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: selectedOption == option
                                ? (isCorrect ? Colors.green : Colors.red)
                                : Colors.blue[700],
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: choicesDisabled
                              ? null
                              : () {
                            setState(() {
                              selectedOption = option;
                              _animationController.reset();
                              isCorrect = isCorrectOption(option);
                              if (!isCorrect) {
                                _animateShake();
                              }
                              choicesDisabled = true;
                            });
                          },
                          child: Text(
                            option,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isCorrect) {
                      widget.onNextQuestion(true);
                      choicesDisabled = false;
                    } else {
                      // Display a "Retry" button if the answer is incorrect
                      selectedOption = null;
                      choicesDisabled = false;
                      widget.streak = 0;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[700],
                  padding: EdgeInsets.all(20),
                ),
                child: Text(
                  isCorrect ? 'Next' : 'Retry',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              Text('Streak: ${widget.streak}',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  bool isCorrectOption(String option) {
    return option == widget.quiz.correctAnswer;
  }

  void _animateShake() {
    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fadeInController.dispose();
    super.dispose();
  }
}

class Quiz {
  final String question;
  final String correctAnswer;
  final List<String> options;

  Quiz({
    required this.question,
    required this.correctAnswer,
    required this.options,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    try {
      return Quiz(
        question: _decodeHtmlEntities(json['question'] ?? 'No Question'),
        correctAnswer:
        _decodeHtmlEntities(json['correct_answer'] ?? 'No Answer'),
        options: List<String>.from(
          (json['incorrect_answers'] ?? []),
        )..add(_decodeHtmlEntities(json['correct_answer'] ?? 'No Answer')),
      );
    } catch (e) {
      print('Error creating Quiz from JSON: $e');
      return Quiz(
        question: 'Error parsing question',
        correctAnswer: 'Error parsing answer',
        options: ['Error', 'Error', 'Error', 'Error'],
      );
    }
  }

  static String _decodeHtmlEntities(String input) {
    try {
      var document = parse(input);
      String decodedString = parse(document.body!.text).documentElement!.text;
      return decodedString;
    } catch (e) {
      print('Error decoding HTML entities: $e');
      return 'Decoding Error';
    }
  }
}
