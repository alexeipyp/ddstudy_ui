import 'package:json_annotation/json_annotation.dart';

import '../../db_model.dart';

part 'comment_stats.g.dart';

@JsonSerializable()
class CommentStats implements DBModel {
  @override
  String? id;
  int likesAmount;
  DateTime? whenLiked;

  CommentStats({
    this.id,
    required this.likesAmount,
    this.whenLiked,
  });

  factory CommentStats.fromJson(Map<String, dynamic> json) =>
      _$CommentStatsFromJson(json);
  Map<String, dynamic> toJson() => _$CommentStatsToJson(this);

  @override
  Map<String, dynamic> toMap() => _$CommentStatsToJson(this);

  factory CommentStats.fromMap(Map<String, dynamic> map) =>
      _$CommentStatsFromJson(map);

  CommentStats copyWith({
    String? id,
    int? likesAmount,
    DateTime? whenLiked,
  }) {
    return CommentStats(
      id: id ?? this.id,
      likesAmount: likesAmount ?? this.likesAmount,
      whenLiked: whenLiked ?? this.whenLiked,
    );
  }
}
