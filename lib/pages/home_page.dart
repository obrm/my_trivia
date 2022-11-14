import 'package:flutter/material.dart';
import 'package:my_trivia/pages/game_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? deviceHeight, deviceWidth;

  double currentDifficultyLevel = 0;

  final List<String> difficultyLevels = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: deviceWidth! * 0.01,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _appTitle(),
                  _difficultySlider(),
                  _startGameButton(),
                ],
              ),
            )),
      ),
    );
  }

  Widget _appTitle() {
    return Column(
      children: [
        const Text("My Trivia",
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.w500,
            )),
        Text(difficultyLevels[currentDifficultyLevel.toInt()],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }

  Widget _difficultySlider() {
    return Slider(
        label:
            "Difficulty: ${difficultyLevels[currentDifficultyLevel.toInt()]}",
        min: 0,
        max: 2,
        divisions: 2,
        value: currentDifficultyLevel,
        onChanged: (value) {
          setState(() {
            currentDifficultyLevel = value;
          });
        });
  }

  Widget _startGameButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return GamePage(
              difficultyLevel: difficultyLevels[currentDifficultyLevel.toInt()]
                  .toLowerCase(),
            );
          }),
        );
      },
      color: Colors.blue,
      minWidth: deviceHeight! * 0.8,
      height: deviceHeight! * 0.1,
      child: const Text(
        "Start",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
