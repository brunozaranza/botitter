import 'package:bottiter/core/model/api_response.dart';
import 'package:bottiter/core/model/post.dart';
import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/repository/service/post_service.dart';
import 'package:bottiter/core/repository/service/user_service.dart';
import 'package:bottiter/core/store/home_store.dart';

class HomeViewModel {
  HomeStore store;

  HomeViewModel({this.store});

  fetchAll() async {
    ApiResponse<List<Post>> response = await PostService().requestAll();
    if (response.success) {
      this.store.setPosts(response.result);
    } else {
      this.store.setError(response.msg);
    }
  }

  Future<User> fetchUserById(String id) async {
    ApiResponse<User> response = await UserService().requestBy(id: id);
    if (response.success) {
      return response.result;
    } else {
      return User(name: "Undefined", email: "");
    }
  }

  List<Post> get list {
    if (this.store.posts == null) fetchAll();
    else {
      this.store.posts.sort((a, b) {
        DateTime date1 = DateTime.parse(a.createdAt);
        DateTime date2 = DateTime.parse(b.createdAt);

        return date2.compareTo(date1);
      });
    }
    return this.store.posts;
  }

  String get error {
    return this.store.error;
  }

  dispose() {
    store.dispose();
  }
}
