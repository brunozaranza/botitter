import 'package:bottiter/core/model/api_response.dart';
import 'package:bottiter/core/model/bot_new.dart';
import 'package:bottiter/core/repository/service/base_service.dart';

class BotNewService extends BaseService {

  Future<ApiResponse<List<BotNew>>> requestAll() async {
    ApiResponse response = await getItem(
        url: "https://gb-mobile-app-teste.s3.amazonaws.com/data.json");
    if (response.success) {

      var list = response.result['news'] as List;

      var newsList = list.map((i) =>
          BotNew.fromJson(i)).cast<BotNew>().toList();

      return ApiResponse.success(newsList);
    } else {
      return ApiResponse.error(response.msg);
    }
  }
}
