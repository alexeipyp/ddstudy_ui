import 'package:json_annotation/json_annotation.dart';

part 'register_user_request.g.dart';

@JsonSerializable()
class RegisterUserRequest {
  final String name;
  final String email;
  final String password;
  final String retryPassword;
  final String birthDate;

  RegisterUserRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.retryPassword,
    required this.birthDate,
  });

  factory RegisterUserRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterUserRequestToJson(this);
}
