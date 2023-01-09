import 'package:ddstudy_ui/domain/models/user/subscribe_status.dart';

enum SubscribeStateEnum { subscribed, sentRequest, notSentRequest }

class SubscribeStates {
  static SubscribeStateEnum getSubscribeState(SubscribeStatus subStatus) {
    if (subStatus.isFollowing) {
      return SubscribeStateEnum.subscribed;
    } else if (subStatus.isSubscribeRequestSent) {
      return SubscribeStateEnum.sentRequest;
    } else {
      return SubscribeStateEnum.notSentRequest;
    }
  }
}
