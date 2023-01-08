import 'package:flutter/material.dart';

import 'outlined_container.dart';

class NumericPageIndicator extends StatelessWidget {
  final int count;
  final int? current;
  final double width;
  const NumericPageIndicator({
    Key? key,
    required this.count,
    required this.current,
    this.width = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
        child: Text(
      " ${current! + 1} / $count ",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ));
  }
}
