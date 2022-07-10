class MemberResponse {
  int memberId;

  MemberResponse({required this.memberId});

  factory MemberResponse.fromJson(Map<String, dynamic> json) {
    return MemberResponse(memberId: json['memberId'] as int);
  }

  @override
  String toString() {
    return 'MemberResponse{memberId: $memberId}';
  }
}
