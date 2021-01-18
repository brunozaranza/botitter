import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/ui/view/bot_sliver_app_bar.dart';
import 'package:flutter/material.dart';

class GeneticListView extends StatelessWidget {
  final RefreshCallback onRefresh;
  final List list;
  final User user;
  final IndexedWidgetBuilder builder;

  GeneticListView({
    @required this.builder,
    @required this.list,
    this.onRefresh,
    this.user,
  });

  _listView() {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: BotSliverAppBar(
            expandedHeight: 100,
            user: user,
          ),
          pinned: true,
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate(builder, childCount: list.length),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
      child: _listView(),
      onRefresh: onRefresh,
    );
  }
}
