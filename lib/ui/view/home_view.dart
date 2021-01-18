import 'package:bottiter/core/model/post.dart';
import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/store/home_store.dart';
import 'package:bottiter/core/viewmodel/home_viewmodel.dart';
import 'package:bottiter/ui/view/error_view.dart';
import 'package:bottiter/ui/view/generic_list_view.dart';
import 'package:bottiter/ui/view/loading_view.dart';
import 'package:bottiter/ui/view/post_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin<HomeView> {
  @override
  bool get wantKeepAlive => true;

  HomeViewModel _viewModel;

  _itemListView(Post post) {
    return PostItemView(post: post);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_viewModel == null) {
      _viewModel = Provider.of<HomeViewModel>(context);
    }

    return Observer(builder: (_) {

      if (_viewModel.error != null)
        return BotErrorView(
          msg: _viewModel.error,
        );

      if (_viewModel.list == null) return LoadingView();

      return GeneticListView(
        builder: (_, index) {
          Post post = _viewModel.list[index];
          return _itemListView(post);
        },
        onRefresh: () => _viewModel.fetchAll(),
        list: _viewModel.list,
        user: User(name: "teste"),
      );
    });
  }
}
