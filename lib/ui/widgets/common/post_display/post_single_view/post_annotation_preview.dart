import 'package:flutter/material.dart';

class PostAnnotationPreview extends StatelessWidget {
  final String authorName;
  final String annotation;
  const PostAnnotationPreview({
    Key? key,
    required this.authorName,
    required this.annotation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            "$authorName: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(annotation),
        ],
      ),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 248, 255),
          border: Border.symmetric(
              horizontal: BorderSide(
            width: 3,
            color: Theme.of(context).primaryColor,
          ))),
    );
  }
}
