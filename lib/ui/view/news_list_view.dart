import 'package:bottiter/core/model/bot_new.dart';
import 'package:bottiter/core/model/post.dart';
import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/store/bot_new_store.dart';
import 'package:bottiter/core/viewmodel/bot_new_viewmodel.dart';
import 'package:bottiter/ui/view/error_view.dart';
import 'package:bottiter/ui/view/generic_list_view.dart';
import 'package:bottiter/ui/view/loading_view.dart';
import 'package:bottiter/ui/view/post_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class NewsListView extends StatefulWidget {
  @override
  _NewsListViewState createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView>
    with AutomaticKeepAliveClientMixin<NewsListView> {
  @override
  bool get wantKeepAlive => true;

  BotNewViewModel _viewModel;

  _itemListView(BotNew botNew) {
    return PostItemView(
      post: Post(
        user: User(name: botNew.user.name),
        content: botNew.post.content,
        createdAt: botNew.post.createdAt,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    _viewModel = Provider.of<BotNewViewModel>(context);

    return Observer(builder: (_) {

      if (_viewModel.error != null)
        return BotErrorView(
          msg: _viewModel.error,
        );

      if (_viewModel.list == null) return LoadingView();

      return GeneticListView(
        builder: (_, index) {
          BotNew botNew = _viewModel.list[index];
          return _itemListView(botNew);
        },
        onRefresh: () => _viewModel.fetchAll(),
        list: _viewModel.list,
      );
    });
  }
}
