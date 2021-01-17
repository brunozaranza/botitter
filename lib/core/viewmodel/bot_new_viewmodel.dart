import 'package:bottiter/core/model/api_response.dart';
import 'package:bottiter/core/model/bot_new.dart';
import 'package:bottiter/core/repository/service/bot_new_service.dart';
import 'package:bottiter/core/store/bot_new_store.dart';

class BotNewViewModel {

  BotNewStore store;

  BotNewViewModel({this.store});

  fetchAll() async {
    ApiResponse<List<BotNew>> response = await BotNewService().requestAll();
    if(response.success) {
      this.store.setNews(response.result);
    } else {
      this.store.setError(response.msg);
    }
  }

  List<BotNew> get list {
    if(this.store.news == null) fetchAll();
    return this.store.news;
  }

  String get error {
    return this.store.error;
  }

  dispose() {
    store.dispose();
  }
}