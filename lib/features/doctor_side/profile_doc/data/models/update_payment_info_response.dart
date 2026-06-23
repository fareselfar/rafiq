class UpdatePaymentInfoResponse {
  final String? message;

  const UpdatePaymentInfoResponse({this.message});

  factory UpdatePaymentInfoResponse.fromJson(Map<String, dynamic> json) {
    return UpdatePaymentInfoResponse(message: json["message"]);
  }
}
