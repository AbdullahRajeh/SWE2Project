import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/QuizPage.dart';

class QuizSection extends StatefulWidget {
  const QuizSection({super.key});

  @override
  State<QuizSection> createState() => _QuizSectionState();
}

class _QuizSectionState extends State<QuizSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
            ),

            Image(
              image: AssetImage('Assets/Images/Exams.png'),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
      
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Quizzes',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Text(
                'Quizzes are a great way to test your knowledge on a subject. They are also a great way to learn new things. Take a quiz to test your knowledge on a subject you already know, or take a quiz to learn something new!',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const QuizPage())
                      );
                },
                child: Text(
                  'Quiz',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue[900],
                  ),
                  ),
              ),
            ),

            
            
          ],
        ),
      )
    );
  }
}
