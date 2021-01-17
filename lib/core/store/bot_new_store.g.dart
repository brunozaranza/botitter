// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bot_new_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BotNewStore on _BotNewBase, Store {
  final _$newsAtom = Atom(name: '_BotNewBase.news');

  @override
  List<BotNew> get news {
    _$newsAtom.reportRead();
    return super.news;
  }

  @override
  set news(List<BotNew> value) {
    _$newsAtom.reportWrite(value, super.news, () {
      super.news = value;
    });
  }

  final _$errorAtom = Atom(name: '_BotNewBase.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$_BotNewBaseActionController = ActionController(name: '_BotNewBase');

  @override
  dynamic setNews(List<BotNew> list) {
    final _$actionInfo =
        _$_BotNewBaseActionController.startAction(name: '_BotNewBase.setNews');
    try {
      return super.setNews(list);
    } finally {
      _$_BotNewBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setError(String error) {
    final _$actionInfo =
        _$_BotNewBaseActionController.startAction(name: '_BotNewBase.setError');
    try {
      return super.setError(error);
    } finally {
      _$_BotNewBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
news: ${news},
error: ${error}
    ''';
  }
}
