import 'package:flutter/material.dart';

class NonePostWidget extends StatelessWidget {
  final String textMessage;
  const NonePostWidget({
    Key? key,
    required this.textMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color widgetColor = Colors.blueGrey;
    var screenSize = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo_camera,
                  color: widgetColor,
                  size: screenSize.width / 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text(
                    textMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: widgetColor,
                    ),
                  ),
                )
              ]),
        ),
      ],
    );
  }
}
