import 'dart:io';

class UploadFileRequest {
  final File file;
  final String fileType;
  final String fileName;
  final String? notes;

  const UploadFileRequest({
    required this.file,
    required this.fileType,
    required this.fileName,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'FileType': fileType, 'FileName': fileName};

    if (notes != null) {
      map['Notes'] = notes;
    }

    return map;
  }
}
