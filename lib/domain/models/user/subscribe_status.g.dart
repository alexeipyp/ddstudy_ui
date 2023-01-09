// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribe_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscribeStatus _$SubscribeStatusFromJson(Map<String, dynamic> json) =>
    SubscribeStatus(
      isSubscribeRequestSent: json['isSubscribeRequestSent'] as bool,
      isFollowing: json['isFollowing'] as bool,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$SubscribeStatusToJson(SubscribeStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isSubscribeRequestSent': instance.isSubscribeRequestSent,
      'isFollowing': instance.isFollowing,
    };
