import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final int maxQuestions = 10;

  List? questions;
  int currentQuestionCount = 0;

  BuildContext context;

  GamePageProvider({required this.context}) {
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionsFromAPI();
  }

  Future<void> _getQuestionsFromAPI() async {
    var response = await dio.get(
      '',
      queryParameters: {
        'amount': maxQuestions,
        'type': 'boolean',
        'difficulty': 'easy',
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
}
