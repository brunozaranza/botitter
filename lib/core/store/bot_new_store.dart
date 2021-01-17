import 'package:bottiter/core/model/bot_new.dart';
import 'package:mobx/mobx.dart';

part 'bot_new_store.g.dart';

class BotNewStore = _BotNewBase with _$BotNewStore;

abstract class _BotNewBase with Store {

  @observable
  List<BotNew> news;

  @observable
  String error;

  @action
  setNews(List<BotNew> list){
    this.news = list;
  }

  @action
  setError(String error){
    this.error = error;
  }

  dispose() {
    this.news.clear();
    this.news = null;
    this.error = null;
  }
}