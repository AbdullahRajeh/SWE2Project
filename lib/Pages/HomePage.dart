import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/Articles.dart';
import 'package:flutter_application_2/Pages/CoursePage.dart';
import 'package:flutter_application_2/Pages/Profile.dart';
import 'package:flutter_application_2/Pages/QuizPage.dart';
import 'package:flutter_application_2/Pages/QuizSection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: [
          const ArticlePage(),
          const QuizSection(),
          const CoursePage(),
          const Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Section',
          ),
        ],
      ),
    );
  }
}
