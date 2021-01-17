import 'package:bottiter/core/model/bot_new.dart';
import 'package:bottiter/core/store/bot_new_store.dart';
import 'package:bottiter/core/viewmodel/bot_new_viewmodel.dart';
import 'package:bottiter/ui/view/bot_sliver_app_bar.dart';
import 'package:bottiter/ui/view/error_view.dart';
import 'package:bottiter/ui/view/loading_view.dart';
import 'package:bottiter/ui/view/post_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class NewsListView extends StatefulWidget {

  @override
  _NewsListViewState createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> with AutomaticKeepAliveClientMixin<NewsListView> {
  @override
  bool get wantKeepAlive => true;

  BotNewViewModel _viewModel;

  Future<void> _onRefresh() async {
    _viewModel.fetchAll();
  }

  _listView() {
    return Observer(builder: (_) {
      if (_viewModel.error != null)
        return BotErrorView(
          msg: _viewModel.error,
        );

      if (_viewModel.list == null) return LoadingView();

      return CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: BotSliverAppBar(expandedHeight: 100),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
                  BotNew botNew = _viewModel.list[index];
                  return _itemListView(botNew);
                },
                childCount: _viewModel.list.length
            ),
          )
        ],
      );
    });
  }

  _itemListView(BotNew botNew) {
    return PostItemView(
      name: botNew.user.name,
      content: botNew.post.content,
      date: botNew.post.editedAt ?? botNew.post.createdAt,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_viewModel == null) {
      _viewModel = BotNewViewModel(store: Provider.of<BotNewStore>(context));
    }

    return RefreshIndicator(child: _listView(), onRefresh: _onRefresh);
  }
}