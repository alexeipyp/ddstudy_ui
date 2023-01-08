import 'package:json_annotation/json_annotation.dart';

import 'package:ddstudy_ui/domain/db_model.dart';

part 'post_stats.g.dart';

@JsonSerializable()
class PostStats implements DBModel {
  @override
  final String? id;
  final int commentsAmount;
  final int likesAmount;
  final DateTime? whenLiked;

  PostStats({
    this.id,
    required this.commentsAmount,
    required this.likesAmount,
    this.whenLiked,
  });

  factory PostStats.fromJson(Map<String, dynamic> json) =>
      _$PostStatsFromJson(json);
  Map<String, dynamic> toJson() => _$PostStatsToJson(this);

  @override
  Map<String, dynamic> toMap() => _$PostStatsToJson(this);

  factory PostStats.fromMap(Map<String, dynamic> map) =>
      _$PostStatsFromJson(map);

  PostStats copyWith({
    String? id,
    int? commentsAmount,
    int? likesAmount,
    DateTime? whenLiked,
  }) {
    return PostStats(
      id: id ?? this.id,
      commentsAmount: commentsAmount ?? this.commentsAmount,
      likesAmount: likesAmount ?? this.likesAmount,
      whenLiked: whenLiked ?? this.whenLiked,
    );
  }
}
