class MedicalFileResponse {
  final int id;
  final String title;
  final String filePath;
  final String fileType;
  final String formattedDate;
  final String notes;

  const MedicalFileResponse({
    required this.id,
    required this.title,
    required this.filePath,
    required this.fileType,
    required this.formattedDate,
    required this.notes,
  });

  factory MedicalFileResponse.fromJson(Map<String, dynamic> json) {
    return MedicalFileResponse(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      filePath: json['filePath'] ?? '',
      fileType: json['fileType'] ?? '',
      formattedDate: json['formattedDate'] ?? '',
      notes: json['notes'] ?? '',
    );
  }
}
