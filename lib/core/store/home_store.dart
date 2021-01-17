import 'package:bottiter/core/model/post.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeBase with _$HomeStore;

abstract class _HomeBase with Store {

  @observable
  List<Post> posts;

  @observable
  String error;

  @action
  setPosts(List<Post> list){
    this.posts = list;
  }

  @action
  setError(String error){
    this.error = error;
  }

  dispose() {
    this.posts.clear();
    this.posts = null;
    this.error = null;
  }
}