import 'package:bottiter/core/model/post.dart';
import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/util/date_util.dart';
import 'package:bottiter/core/viewmodel/login_viewmodel.dart';
import 'package:bottiter/core/viewmodel/new_post_viewmodel.dart';
import 'package:bottiter/ui/view/image_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPostPage extends StatefulWidget {
  final Post editPost;

  NewPostPage({this.editPost});

  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  NewPostViewModel _viewModel;
  User _user;

  @override
  initState(){
    super.initState();
    if(widget.editPost != null) {
      _controller.text = widget.editPost.content;
    }
  }

  _onPressed() {
    setState(() {
      _viewModel.isLoading = true;
    });

    if (widget.editPost == null) {
      _viewModel
          .addPost(Post(user: _user, content: _controller.text))
          .then((isSuccess) {
        if (isSuccess) {
          Navigator.pop(context);
        } else {
          setState(() {
            _viewModel.isLoading = false;
          });
          // TODO: Show a message feedback
        }
      });
    } else {
      _viewModel.editPost(Post(
        id: widget.editPost.id,
        user: widget.editPost.user,
        content: _controller.text,
        createdAt: widget.editPost.createdAt,
        editedAt: DateUtil.parseDateToString(DateTime.now()),
        link: widget.editPost.link,
        imageUrl: widget.editPost.imageUrl,
      )).then((isSuccess) {
        if (isSuccess) {
          Navigator.pop(context);
        } else {
          setState(() {
            _viewModel.isLoading = false;
          });
          // TODO: Show a message feedback
        }
      });
    }
  }

  _appBar() {
    return AppBar(
      centerTitle: true,
      title: Container(
        height: _viewModel.size,
        width: _viewModel.size,
        child: Stack(
          children: [
            CircularProgressIndicator(
              value: _viewModel.textLength / _viewModel.maxTextLength,
              strokeWidth: 3,
              backgroundColor: _viewModel.indicatorColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                  _viewModel.indicatorBackGroundColor),
            ),
            _viewModel.textLength >= _viewModel.maxTextLength - 20
                ? Center(
                    child: Text(
                      "${_viewModel.maxTextLength - _viewModel.textLength}",
                      style: TextStyle(
                          fontSize: 11,
                          color: _viewModel.indicatorColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      actions: [
        _deleteButton(),
        _actionButton(),
      ],
    );
  }

  _actionButton(){
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
      child: _viewModel.isLoading
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      )
          : Container(
        width: 90,
          decoration: BoxDecoration(
            color:
            _viewModel.isButtonDisabled ? Colors.grey : Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: FlatButton(
              onPressed:
              _viewModel.isButtonDisabled ? null : _onPressed,
              child: Text(
                widget.editPost != null ? "EDITAR" : "POSTAR",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 11,),
              ))),
    );
  }

  _deleteButton() {
    if (widget.editPost == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
      child: Container(
        width: 50,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: FlatButton(
              onPressed: () {
                _viewModel.deletePost(widget.editPost);
                Navigator.pop(context);
              },
              child: Icon(Icons.delete, color: Colors.white, size: 20,))),
    );
  }

  _body() {

    _controller.addListener(() {
      _viewModel.textLength = _controller.text.length;
      _viewModel.size = _viewModel.textLength >= (_viewModel.maxTextLength - 20)
          ? _viewModel.size = 25
          : 20;
      _viewModel.isButtonDisabled =
          _viewModel.textLength > _viewModel.maxTextLength ||
                  _viewModel.textLength == 0
              ? true
              : false;
      setState(() {});
    });

    _focusNode.requestFocus();

    return Column(
      children: [
        SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: ImageProfileView(_user.profilePicture),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      focusNode: _focusNode,
                      controller: _controller,
                      maxLines: 10,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_viewModel == null) {
      _viewModel = NewPostViewModel();
    }

    _user = Provider.of<LoginViewModel>(context).user;

    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
