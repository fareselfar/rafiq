class VerifyResetOtpResponse {
  final bool isSuccess;
  final String message;

  VerifyResetOtpResponse({required this.isSuccess, required this.message});

  factory VerifyResetOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyResetOtpResponse(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
