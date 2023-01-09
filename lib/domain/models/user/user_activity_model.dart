import 'package:json_annotation/json_annotation.dart';

import 'subscribe_status.dart';

part 'user_activity_model.g.dart';

@JsonSerializable()
class UserActivityModel {
  int postsAmount;
  int followersAmount;
  int followingAmount;
  SubscribeStatus subscribeStatus;

  UserActivityModel({
    required this.postsAmount,
    required this.followersAmount,
    required this.followingAmount,
    required this.subscribeStatus,
  });

  factory UserActivityModel.fromJson(Map<String, dynamic> json) =>
      _$UserActivityModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserActivityModelToJson(this);
}
