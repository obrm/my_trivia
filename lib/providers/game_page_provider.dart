import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();

  BuildContext context;

  GamePageProvider({required this.context}) {
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    print("hello");
  }
}
