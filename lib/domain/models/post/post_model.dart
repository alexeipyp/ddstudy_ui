// Generated by https://quicktype.io

import 'package:ddstudy_ui/domain/models/post/post_attach.dart';
import 'package:ddstudy_ui/domain/models/post/post_stats.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user/user.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  String id;
  String? annotation;
  User author;
  List<PostAttach> attaches;
  String uploadDate;
  PostStats stats;

  PostModel({
    required this.id,
    this.annotation,
    required this.author,
    required this.attaches,
    required this.uploadDate,
    required this.stats,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
