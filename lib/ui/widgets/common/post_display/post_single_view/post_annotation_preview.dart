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
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 10,
      ),
      child: Row(
        children: [
          Text("$authorName: $annotation"),
        ],
      ),
    );
  }
}
