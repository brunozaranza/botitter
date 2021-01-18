import 'package:bottiter/core/model/post.dart';
import 'package:bottiter/core/util/date_util.dart';
import 'package:bottiter/core/util/image_util.dart';
import 'package:bottiter/core/util/launch_util.dart';
import 'package:bottiter/ui/view/image_profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PostItemView extends StatelessWidget {

  final Post post;

  PostItemView({
    this.post,
  });

  _userInfo() {
    return Row(
      children: [
        Text(
          post.user.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(width: 4.0),
        Text("•"),
        SizedBox(width: 4.0),
        Text(
          DateUtil.textTimeAgo(post.createdAt),
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  _content() {
    return Text(post.content);
  }

  _postItem() {
    return Column(
      children: [
        SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageProfileView(post.user.profilePicture),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _userInfo(),
                    SizedBox(height: 2),
                    _content(),
                    post.imageUrl == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: InkWell(
                                onTap: () => LaunchUtil.launchInBrowser(post.link),
                                child: Card(
                                  child: Image.network(post.imageUrl),
                                )),
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _postItem(),
    );
  }
}
