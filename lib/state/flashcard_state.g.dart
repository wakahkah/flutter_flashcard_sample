// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FlashCardState on _FlashCardState, Store {
  late final _$currIndexAtom =
      Atom(name: '_FlashCardState.currIndex', context: context);

  @override
  int get currIndex {
    _$currIndexAtom.reportRead();
    return super.currIndex;
  }

  @override
  set currIndex(int value) {
    _$currIndexAtom.reportWrite(value, super.currIndex, () {
      super.currIndex = value;
    });
  }

  late final _$_FlashCardStateActionController =
      ActionController(name: '_FlashCardState', context: context);

  @override
  void nextCard() {
    final _$actionInfo = _$_FlashCardStateActionController.startAction(
        name: '_FlashCardState.nextCard');
    try {
      return super.nextCard();
    } finally {
      _$_FlashCardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void prevCard() {
    final _$actionInfo = _$_FlashCardStateActionController.startAction(
        name: '_FlashCardState.prevCard');
    try {
      return super.prevCard();
    } finally {
      _$_FlashCardStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currIndex: ${currIndex}
    ''';
  }
}
