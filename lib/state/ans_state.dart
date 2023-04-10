import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'ans_state.g.dart';

class AnsState = _AnsState with _$AnsState;

abstract class _AnsState with Store {
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

  @observable
  int statusIndex = 0;

  @action
  void checkAns(String inputText, String ans) {
    statusIndex = inputText.toLowerCase() == ans.toLowerCase() ? 1 : 2;
  }

  _resetCardStatus() {
    statusIndex = 0;
  }
}
