import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final int maxQuestions = 10;
  final String difficultyLevel;

  List? questions;
  int currentQuestionCount = 0;
  int correctAnswersCount = 0;

  BuildContext context;

  GamePageProvider({required this.context, required this.difficultyLevel}) {
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    var response = await dio.get(
      '',
      queryParameters: {
        'amount': maxQuestions,
        'type': 'boolean',
        'difficulty': difficultyLevel,
      },
    );

    var data = jsonDecode(
      response.toString(),
    );
    questions = data["results"];
    notifyListeners();
  }

  String getCurrentQuestion() {
    return questions![currentQuestionCount]["question"];
  }

  void answerQuestion(String answer) async {
    bool isCorrect =
        questions![currentQuestionCount]["correct_answer"] == answer;
    if (isCorrect) {
      correctAnswersCount++;
    }
    currentQuestionCount++;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: isCorrect ? Colors.green : Colors.red,
            title: Icon(
              isCorrect ? Icons.check_circle : Icons.cancel_sharp,
              color: Colors.white,
            ),
          );
        });
    await Future.delayed(
      const Duration(seconds: 1),
    );
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    if (currentQuestionCount == maxQuestions) {
      currentQuestionCount = 0;
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: const Text(
              "Game Over!",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            content: Text("Score: $correctAnswersCount/$maxQuestions"),
          );
        });
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    correctAnswersCount = 0;
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
