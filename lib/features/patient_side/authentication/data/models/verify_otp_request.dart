class VerifyResetOtpRequest {
  final String email;
  final String otp;

  VerifyResetOtpRequest({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }
}
