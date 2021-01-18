import 'package:bottiter/core/model/user.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserBase with _$UserStore;

abstract class _UserBase with Store {

  @observable
  User user;

  @action
  setUser(User user){
    this.user = user;
  }

  dispose() {
    this.user = null;
  }
}