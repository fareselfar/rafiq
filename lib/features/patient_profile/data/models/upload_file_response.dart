class UploadFileResponse {
  final String message;

  const UploadFileResponse({required this.message});

  factory UploadFileResponse.fromJson(Map<String, dynamic> json) {
    return UploadFileResponse(message: json['message'] as String? ?? '');
  }
}
