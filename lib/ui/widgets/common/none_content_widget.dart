import 'package:ddstudy_ui/domain/enums/content_type.dart';
import 'package:flutter/material.dart';

class NoneContentWidget extends StatelessWidget {
  final ContentTypeEnum contentType;
  const NoneContentWidget({
    Key? key,
    required this.contentType,
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
                  ContentEnums.contentTypeIcon[contentType]!,
                  color: widgetColor,
                  size: screenSize.width / 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text(
                    ContentEnums.contentTypeText[contentType]!,
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
