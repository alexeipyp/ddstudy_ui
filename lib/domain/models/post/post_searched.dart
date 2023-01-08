import 'package:ddstudy_ui/domain/db_model.dart';

class PostSearched implements DBModel {
  @override
  final String id;
  PostSearched({
    required this.id,
  });

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
      };

  factory PostSearched.fromMap(Map<String, dynamic> map) => PostSearched(
        id: map['id'] as String,
      );
}
