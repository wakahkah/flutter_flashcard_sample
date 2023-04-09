import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter_flashcard/flashcard.dart';
import 'package:flutter_flashcard/flashcard_view.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Flashcard> _flashcards = [
    Flashcard(question: "What language does flutter uses?", answer: "Dart"),
    Flashcard(question: "What language does React uses?", answer: "JavaScript"),
    Flashcard(
        question: "What language does Angular uses?", answer: "JavaScript"),
    Flashcard(
        question: "What language does Electron uses?", answer: "JavaScript"),
    Flashcard(
        question: "What language does React Native uses?", answer: "JavaScript")
  ];

  int _currIndex = 0;
  int _statusIndex = 0;

  List<Icon> statusIco = [
    const Icon(
      Icons.edit,
      color: Colors.grey,
      size: 30.0,
    ),
    const Icon(
      Icons.done,
      color: Colors.green,
      size: 30.0,
    ),
    const Icon(
      Icons.error_outline,
      color: Colors.amber,
      size: 30.0,
    )
  ];

  var ansController = TextEditingController();
  var flipController = FlipCardController();

  // 0: init, 1: correct, 2: wrong

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('FlashCard Quiz')),
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: FlipCard(
                        front: FlashcardView(
                          text: _flashcards[_currIndex].question,
                        ),
                        back: FlashcardView(
                          text: _flashcards[_currIndex].answer,
                        ),
                        controller: flipController,
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton.icon(
                              onPressed: previousCard,
                              icon: Icon(Icons.chevron_left),
                              label: Text('Prev')),
                          FloatingActionButton(
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.volume_up, color: Colors.white),
                              onPressed: () async {
                                await runTextToSpeech(
                                    _flashcards[_currIndex].answer);
                              }),
                          OutlinedButton.icon(
                              onPressed: nextCard,
                              icon: Icon(Icons.chevron_right),
                              label: Text('Next')),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 300, // <-- SEE HERE
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Enter your ans',
                              ),
                              onChanged: checkAns,
                              controller: ansController,
                            ),
                          ),
                          statusIco[_statusIndex]
                        ])
                  ]),
            )));
  }

  void nextCard() {
    setState(() {
      _statusIndex = 0;
      ansController.clear();
      if (!flipController.state!.isFront) {
        flipController.toggleCard();
      }
      _currIndex = (_currIndex + 1 < _flashcards.length) ? _currIndex + 1 : 0;
    });
  }

  void previousCard() {
    setState(() {
      _statusIndex = 0;
      ansController.clear();
      if (!flipController.state!.isFront) {
        flipController.toggleCard();
      }
      _currIndex =
          (_currIndex - 1 >= 0) ? _currIndex - 1 : _flashcards.length - 1;
    });
  }

  void checkAns(String inputText) {
    setState(() {
      _statusIndex = inputText.toLowerCase() ==
              _flashcards[_currIndex].answer.toLowerCase()
          ? 1
          : 2;
    });
  }

  Future<void> runTextToSpeech(String currentTtsString) async {
    FlutterTts flutterTts;
    flutterTts = FlutterTts();
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage("en-US"); //en-GB
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.isLanguageAvailable("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(currentTtsString);
  }
}
