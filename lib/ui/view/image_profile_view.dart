import 'package:bottiter/core/util/image_util.dart';
import 'package:flutter/material.dart';

class ImageProfileView extends StatelessWidget {

  final String profilePicture;

  ImageProfileView(this.profilePicture);

  @override
  Widget build(BuildContext context) {
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
            profilePicture ?? ImageUtil.imgDefault,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
