import 'package:bottiter/core/model/post.dart';
import 'package:bottiter/core/util/date_util.dart';
import 'package:bottiter/core/util/launch_util.dart';
import 'package:bottiter/core/viewmodel/home_viewmodel.dart';
import 'package:bottiter/core/viewmodel/login_viewmodel.dart';
import 'package:bottiter/ui/page/new_post_page.dart';
import 'package:bottiter/ui/view/image_profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class PostItemView extends StatefulWidget {
  final Post post;

  PostItemView({
    this.post,
  });

  @override
  _PostItemViewState createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  LoginViewModel _loginViewModel;
  HomeViewModel _homeViewModel;

  _userInfo() {
    return Row(
      children: [
        Text(
          widget.post.user.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(width: 4.0),
        Text("•"),
        SizedBox(width: 4.0),
        Text(
          DateUtil.textTimeAgo(widget.post.createdAt),
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        Spacer(),
        _loginViewModel.user.email == widget.post.user.email
            ? Container(
                height: 15,
                child: Icon(Icons.edit, size:15),
                )
            : Container(),
      ],
    );
  }

  _content() {
    return Text(widget.post.content);
  }

  _postItem() {
    return Column(
      children: [
        SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageProfileView(widget.post.user.profilePicture),
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
                    widget.post.imageUrl == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: InkWell(
                                onTap: () => LaunchUtil.launchInBrowser(
                                    widget.post.link),
                                child: Card(
                                  child: Image.network(widget.post.imageUrl),
                                )),
                          ),
                    widget.post.editedAt != null
                        ? Column(
                          children: [
                            SizedBox(height: 8),
                            Text(
                                "Editado ${DateUtil.textTimeAgo(widget.post.editedAt).toLowerCase()}",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey.shade500),
                              ),
                          ],
                        )
                        : Container()
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
    _loginViewModel = Provider.of<LoginViewModel>(context);
    _homeViewModel = Provider.of<HomeViewModel>(context);

    return GestureDetector(
      onTap: () {
        if (_loginViewModel.user.email == widget.post.user.email) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return NewPostPage(editPost: widget.post);
          })).then((value) => _homeViewModel.fetchAll());
        }
      },
      child: Container(
        color: Colors.white,
        child: _postItem(),
      ),
    );
  }
}
