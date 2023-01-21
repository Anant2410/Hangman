import 'package:flutter/material.dart';
import 'package:hangman/const/const.dart';
import 'package:hangman/game/figure_widget.dart';
import 'package:hangman/game/letters.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var characters = "abcdefghijklmnopqrstuvwxyz".toUpperCase(); 
  var word = "hang".toUpperCase();
  List<String> selectedchar = [];
  var tries = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Hangman Game"),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      figure(Gameui.hang, tries >= 0),
                      figure(Gameui.head, tries >= 1),
                      figure(Gameui.body, tries >= 2),
                      figure(Gameui.leftArm, tries >= 3),
                      figure(Gameui.rightArm, tries >= 4),
                      figure(Gameui.leftLeg, tries >= 5),
                      figure(Gameui.rightLeg, tries >= 6),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: word
                          .split("")
                          .map((e) => Letter(
                              e, !selectedchar.contains(e.toUpperCase())))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                crossAxisCount: 7,
                children: characters.split("").map((e) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black54),
                    onPressed: selectedchar.contains(e.toUpperCase())
                        ? null
                        : () {
                            setState(() {
                              selectedchar.add(e.toUpperCase());
                              if (!word.split("").contains(e.toUpperCase())) {
                                tries++;
                              }
                            });
                          },
                    child: Text(
                      e,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
