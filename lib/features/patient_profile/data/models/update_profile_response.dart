class UpdateProfileResponse {
  final String? message;

  const UpdateProfileResponse({this.message});

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(message: json['message']);
  }
}
