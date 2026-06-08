class SendResetOtpResponse {
  final bool isSuccess;
  final String message;

  SendResetOtpResponse({required this.isSuccess, required this.message});

  factory SendResetOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendResetOtpResponse(
      isSuccess: json['isSuccess'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
