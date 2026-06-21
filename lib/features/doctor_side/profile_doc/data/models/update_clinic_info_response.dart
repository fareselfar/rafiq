class UpdateClinicInfoResponse {
  final String message;

  const UpdateClinicInfoResponse({required this.message});

  factory UpdateClinicInfoResponse.fromJson(Map<String, dynamic> json) {
    return UpdateClinicInfoResponse(message: json['message'] ?? '');
  }
}
