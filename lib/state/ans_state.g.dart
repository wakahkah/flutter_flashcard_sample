// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ans_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AnsState on _AnsState, Store {
  late final _$statusIndexAtom =
      Atom(name: '_AnsState.statusIndex', context: context);

  @override
  int get statusIndex {
    _$statusIndexAtom.reportRead();
    return super.statusIndex;
  }

  @override
  set statusIndex(int value) {
    _$statusIndexAtom.reportWrite(value, super.statusIndex, () {
      super.statusIndex = value;
    });
  }

  late final _$_AnsStateActionController =
      ActionController(name: '_AnsState', context: context);

  @override
  void checkAns(String inputText, String ans) {
    final _$actionInfo =
        _$_AnsStateActionController.startAction(name: '_AnsState.checkAns');
    try {
      return super.checkAns(inputText, ans);
    } finally {
      _$_AnsStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
statusIndex: ${statusIndex}
    ''';
  }
}
