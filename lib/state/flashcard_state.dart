import 'package:mobx/mobx.dart';

import '../model/flashcard.dart';

part 'flashcard_state.g.dart';

class FlashCardState = _FlashCardState with _$FlashCardState;

abstract class _FlashCardState with Store {
  List<Flashcard> flashcards = [
    Flashcard(question: "What language does flutter uses?", answer: "Dart"),
    Flashcard(question: "What language does React uses?", answer: "JavaScript"),
    Flashcard(
        question: "What language does Angular uses?", answer: "JavaScript"),
    Flashcard(
        question: "What language does Electron uses?", answer: "JavaScript"),
    Flashcard(
        question: "What language does React Native uses?", answer: "JavaScript")
  ].asObservable();

  @observable
  int currIndex = 0;

  @computed
  Flashcard get curFlashCard => flashcards[currIndex];

  @action
  void nextCard() {
    //_resetCardStatus();
    currIndex = (currIndex + 1 < flashcards.length) ? currIndex + 1 : 0;
  }

  @action
  void prevCard() {
    //_resetCardStatus();
    currIndex = (currIndex - 1 >= 0) ? currIndex - 1 : flashcards.length - 1;
  }

  /*_resetCardStatus() {
    statusIndex = 0;
  }*/
}
