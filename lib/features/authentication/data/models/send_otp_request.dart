class SendResetOtpRequest {
  final String email;

  SendResetOtpRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}
