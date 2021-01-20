import 'package:bottiter/core/model/api_response.dart';
import 'package:bottiter/core/model/bot_new.dart';
import 'package:bottiter/core/repository/service/bot_new_service.dart';
import 'package:bottiter/core/store/bot_new_store.dart';

class BotNewViewModel {

  BotNewStore store;

  BotNewViewModel({this.store});

  fetchAll() async {
    this.store.setError(null);
    ApiResponse<List<BotNew>> response = await BotNewService().requestAll();
    if(response.success) {
      this.store.setNews(response.result);
    } else {
      this.store.setError(response.msg);
    }
  }

  List<BotNew> get list {
    if(this.store.news == null) fetchAll();
    else {
      this.store.news.sort((a, b) {
        DateTime date1 = DateTime.parse(a.post.createdAt);
        DateTime date2 = DateTime.parse(b.post.createdAt);

        return date2.compareTo(date1);
      });
    }
    return this.store.news;
  }

  String get error {
    return this.store.error;
  }

  dispose() {
    store.dispose();
  }
}