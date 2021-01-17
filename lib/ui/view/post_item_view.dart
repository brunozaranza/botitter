import 'package:bottiter/core/util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

class PostItemView extends StatefulWidget {
  final String profileUrl;
  final String name;
  final String content;
  final String date;
  final String imageContentUrl;
  final String link;

  PostItemView({
    this.profileUrl =
        "https://media-exp1.licdn.com/dms/image/C4D0BAQE-T3s9Xp0otw/company-logo_200_200/0/1610139063759?e=1619049600&v=beta&t=5lF89geWt4pHpcWeDRKI8cv7doApDANTItWYsXu_vBQ",
    @required this.name,
    @required this.content,
    @required this.date,
    this.imageContentUrl,
    this.link,
  });

  @override
  _PostItemViewState createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView>
    with AutomaticKeepAliveClientMixin<PostItemView> {

  @override
  bool get wantKeepAlive => true;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  _imageProfile() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0,
                spreadRadius: 0.1,
                color: Colors.grey.shade300)
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipOval(
          child: Image.network(
            widget.profileUrl,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  _userInfo() {
    return Row(
      children: [
        Text(
          widget.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(width: 4.0),
        Text("•"),
        SizedBox(width: 4.0),
        Text(
          DateUtil.textTimeAgo(widget.date),
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  _content() {
    return Text(widget.content);
  }

  _postItem() {
    return Column(
      children: [
        SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imageProfile(),
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
                    widget.imageContentUrl == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: InkWell(
                                onTap: () => _launchInBrowser(widget.link),
                                child: Card(
                                  child: Image.network(widget.imageContentUrl),
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
