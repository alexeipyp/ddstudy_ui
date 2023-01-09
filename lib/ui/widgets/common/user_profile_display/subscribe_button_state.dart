import 'package:flutter/material.dart';

import '../../../../domain/enums/subscribe_state.dart';

class SubscribeButtonState {
  static Map<SubscribeStateEnum, ButtonStyle> subscribeButtonStyle = {
    SubscribeStateEnum.subscribed: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.blue),
    ),
    SubscribeStateEnum.sentRequest: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
    ),
    SubscribeStateEnum.notSentRequest: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.amber),
    ),
  };

  static Map<SubscribeStateEnum, String> subscribeButtonText = {
    SubscribeStateEnum.subscribed: "Unfollow",
    SubscribeStateEnum.sentRequest: "Reviewing",
    SubscribeStateEnum.notSentRequest: "Subscribe",
  };
}
