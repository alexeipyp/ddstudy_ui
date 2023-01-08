import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final int? current;
  final double width;
  const PageIndicator({
    Key? key,
    required this.count,
    required this.current,
    this.width = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[];
    for (var i = 0; i < count; i++) {
      widgets.add(Icon(
        i == (current ?? 0) ? Icons.circle : Icons.circle_outlined,
        size: width,
        color: Theme.of(context).primaryColor,
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }
}
