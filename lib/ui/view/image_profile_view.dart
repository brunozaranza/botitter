import 'package:bottiter/core/util/image_util.dart';
import 'package:flutter/material.dart';

class ImageProfileView extends StatelessWidget {

  final String profilePicture;
  final double size;

  ImageProfileView(this.profilePicture, {this.size = 40.0});

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
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
