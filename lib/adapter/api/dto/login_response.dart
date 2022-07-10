import 'package:nplusone/adapter/api/dto/member_response.dart';

class LoginResponse {
  String accessToken;
  MemberResponse member;

  LoginResponse({
    required this.accessToken,
    required this.member,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] as String,
      member: MemberResponse.fromJson(json['member']),
    );
  }

  @override
  String toString() {
    return 'LoginResponse{accessToken: $accessToken, member: $member}';
  }
}