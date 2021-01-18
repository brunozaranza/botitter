import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/ui/page/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottiter/core/repository/database/database.dart';

class BotSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final User user;

  BotSliverAppBar({@required this.expandedHeight, this.user});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          AppBar(
            title: Container(
              height: 45,
              child: Image.asset("assets/images/logo.png"),
            ),
            centerTitle: true,
          ),
          user == null
              ? Container()
              : Positioned(
                  top: 45,
                  child: Opacity(
                    opacity: (1 - shrinkOffset / expandedHeight),
                    child: SizedBox(
                      height: expandedHeight,
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        trailing: Container(
                            width: 60,
                            child: FlatButton(
                                onPressed: () {
                                  Database.saveUser(null);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
                                },
                                child: Text(
                                  "SAIR",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ))),
                        title: Text(
                          "Bem-vinde, ${user.name}",
                          style: TextStyle(
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => user == null ? 56 : expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
