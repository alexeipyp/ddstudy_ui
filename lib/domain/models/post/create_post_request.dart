import 'package:json_annotation/json_annotation.dart';

import '../attach/attach_meta.dart';

part 'create_post_request.g.dart';

@JsonSerializable()
class CreatePostRequest {
  String annotation;
  List<AttachMeta> attaches;

  CreatePostRequest({
    required this.annotation,
    required this.attaches,
  });

  factory CreatePostRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePostRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreatePostRequestToJson(this);
}
