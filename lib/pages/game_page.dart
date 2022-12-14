import 'package:flutter/material.dart';
import 'package:my_trivia/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  final String difficultyLevel;

  double? deviceHeight, deviceWidth;

  GamePageProvider? pageProvider;

  GamePage({required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(
        context: context,
        difficultyLevel: difficultyLevel,
      ),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      pageProvider = context.watch<GamePageProvider>();
      if (pageProvider!.questions != null) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: deviceHeight! * 0.05,
              ),
              child: _gameUI(),
            ),
          ),
        );
      } else {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.white,
        ));
      }
    });
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: deviceHeight! * 0.01,
            ),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _questionText() {
    return Text(pageProvider!.getCurrentQuestion(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ));
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider!.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: deviceHeight! * 0.8,
      height: deviceHeight! * 0.1,
      child: const Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider!.answerQuestion("False");
      },
      color: Colors.red,
      minWidth: deviceHeight! * 0.8,
      height: deviceHeight! * 0.1,
      child: const Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
