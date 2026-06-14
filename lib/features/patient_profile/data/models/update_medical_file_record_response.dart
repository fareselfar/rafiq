class UpdateMedicalRecordResponse {
  final String? message;

  const UpdateMedicalRecordResponse({this.message});

  factory UpdateMedicalRecordResponse.fromJson(Map<String, dynamic> json) {
    return UpdateMedicalRecordResponse(message: json['message'] as String?);
  }
}
