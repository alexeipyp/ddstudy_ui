import 'package:ddstudy_ui/domain/db_model.dart';

class PostSubscribed implements DBModel {
  @override
  final String id;
  PostSubscribed({
    required this.id,
  });

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
      };

  factory PostSubscribed.fromMap(Map<String, dynamic> map) => PostSubscribed(
        id: map['id'] as String,
      );
}
