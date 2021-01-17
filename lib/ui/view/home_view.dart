import 'package:bottiter/core/model/post.dart';
import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/store/home_store.dart';
import 'package:bottiter/core/viewmodel/home_viewmodel.dart';
import 'package:bottiter/ui/view/bot_sliver_app_bar.dart';
import 'package:bottiter/ui/view/error_view.dart';
import 'package:bottiter/ui/view/loading_view.dart';
import 'package:bottiter/ui/view/post_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin<HomeView> {
  @override
  bool get wantKeepAlive => true;

  HomeViewModel _viewModel;

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
              Post post = _viewModel.list[index];
              return _itemListView(post);
            },
                childCount: _viewModel.list.length
            ),
          )
        ],
      );
    });
  }

  _itemListView(Post post) {

      return PostItemView(
        name: post.user.name,
        profileUrl: post.user.profilePicture,
        content: post.content,
        date: post.createdAt,
        imageContentUrl: post.imageUrl,
        link: post.link,
      );
  }

  @override
  Widget build(BuildContext context) {
    if (_viewModel == null) {
      _viewModel = HomeViewModel(store: Provider.of<HomeStore>(context));
    }

    return RefreshIndicator(child: _listView(), onRefresh: _onRefresh);
  }
}
