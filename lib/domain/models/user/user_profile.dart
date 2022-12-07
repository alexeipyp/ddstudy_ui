import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  final String id;
  final String name;
  final String avatarLink;
  final String email;
  final String birthDate;

  UserProfile({
    required this.id,
    required this.name,
    required this.avatarLink,
    required this.email,
    required this.birthDate,
  });

  DateTime getParsedBirthDate() {
    return DateTime.parse(birthDate);
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
