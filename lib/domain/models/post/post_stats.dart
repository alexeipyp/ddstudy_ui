import 'package:json_annotation/json_annotation.dart';

import 'package:ddstudy_ui/domain/db_model.dart';

part 'post_stats.g.dart';

@JsonSerializable()
class PostStats implements DBModel {
  @override
  final String? id;
  final int commentsAmount;
  final int likesAmount;
  final bool isLiked;

  PostStats({
    this.id,
    required this.commentsAmount,
    required this.likesAmount,
    required this.isLiked,
  });

  factory PostStats.fromJson(Map<String, dynamic> json) =>
      _$PostStatsFromJson(json);
  Map<String, dynamic> toJson() => _$PostStatsToJson(this);

  @override
  Map<String, dynamic> toMap() => _$PostStatsToJson(this);

  factory PostStats.fromMap(Map<String, dynamic> map) => PostStats(
        id: map['id'] as String?,
        commentsAmount: map['commentsAmount'] as int,
        likesAmount: map['likesAmount'] as int,
        isLiked: map['isLiked'] == 1 ? true : false,
      );

  PostStats copyWith({
    String? id,
    int? commentsAmount,
    int? likesAmount,
    bool? isLiked,
  }) {
    return PostStats(
      id: id ?? this.id,
      commentsAmount: commentsAmount ?? this.commentsAmount,
      likesAmount: likesAmount ?? this.likesAmount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
