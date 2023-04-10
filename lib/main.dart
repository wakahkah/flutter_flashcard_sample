import 'package:flip_card/flip_card_controller.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';

import 'state/ans_state.dart';
import 'state/flashcard_state.dart';
import 'widget/flashcard_view.dart';

void main() {
  runApp(const FlashCardScreen());
}

class FlashCardScreen extends StatefulWidget {
  const FlashCardScreen({super.key});
  static String flashcardScreenRoute = '/flashcard';

  @override
  State<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen> {
  final _flashCardState = FlashCardState();
  final _ansState = AnsState();

  var ansController = TextEditingController();
  var flipController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('FlashCard Quiz')),
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: FlipCard(
                        front: FlashcardView(
                          text: _flashCardState.curFlashCard.question,
                        ),
                        back: FlashcardView(
                          text: _flashCardState.curFlashCard.answer,
                        ),
                        controller: flipController,
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton.icon(
                              onPressed: previousCard,
                              icon: const Icon(Icons.chevron_left),
                              label: const Text('Prev')),
                          FloatingActionButton(
                              backgroundColor: Colors.blue,
                              child: const Icon(Icons.volume_up,
                                  color: Colors.white),
                              onPressed: () async {
                                await runTextToSpeech(
                                    _flashCardState.curFlashCard.answer);
                              }),
                          OutlinedButton.icon(
                              onPressed: nextCard,
                              icon: const Icon(Icons.chevron_right),
                              label: const Text('Next')),
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
                          _ansState.statusIco[_ansState.statusIndex]
                        ])
                  ]),
            )));
  }

  void nextCard() {
    setState(() {
      _resetStatus();
      _flashCardState.nextCard();
    });
  }

  void previousCard() {
    setState(() {
      _resetStatus();
      _flashCardState.prevCard();
    });
  }

  void checkAns(String inputText) {
    setState(() {
      _ansState.checkAns(inputText, _flashCardState.curFlashCard.answer);
    });
  }

  _resetStatus() {
    ansController.clear();
    _ansState.statusIndex = 0;
    _setCardFront();
  }

  _setCardFront() {
    if (!flipController.state!.isFront) {
      flipController.toggleCard();
    }
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
