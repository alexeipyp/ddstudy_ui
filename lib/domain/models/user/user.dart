import 'package:json_annotation/json_annotation.dart';

import 'package:ddstudy_ui/domain/db_model.dart';

part 'user.g.dart';

@JsonSerializable()
class User implements DBModel {
  @override
  final String id;
  final String name;
  final String? avatarLink;
  final String email;
  final DateTime birthDate;

  User({
    required this.id,
    required this.name,
    this.avatarLink,
    required this.email,
    required this.birthDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  Map<String, dynamic> toMap() => _$UserToJson(this);

  factory User.fromMap(Map<String, dynamic> map) => _$UserFromJson(map);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.avatarLink == avatarLink &&
        other.email == email &&
        other.birthDate == birthDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        avatarLink.hashCode ^
        email.hashCode ^
        birthDate.hashCode;
  }
}
