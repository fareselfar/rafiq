// import 'package:file_picker/file_picker.dart' as picker;
// import '../../data/models/file_model.dart';
// import '../../data/models/file_type.dart';
// import '../../data/repositories/file_repository.dart';

// class FileController {
//   final FileRepository repository;

//   FileController(this.repository);

//   picker.PlatformFile? selectedFile;
//   FileType selectedType = FileType.tests;

//   Future<String?> pickFile() async {
//     final result = await picker.FilePicker.platform.pickFiles(
//       type: picker.FileType.custom,
//       allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
//     );

//     if (result != null) {
//       final file = result.files.first;

//       final sizeInMB = file.size / (1024 * 1024);
//       if (sizeInMB > 10) {
//         return "الملف يجب ألا يزيد عن 10 ميجا";
//       }

//       selectedFile = file;
//     }

//     return null;
//   }

//   String? addFile(String notes) {
//     if (selectedFile == null) {
//       return "اختر ملف أولاً";
//     }

//     final file = FileModel(
//       title: selectedFile!.name,
//       date: DateTime.now().toString(),
//       notes: "assets/icons/pdf.svg",
//       fileType: selectedType,
//     );

//     repository.addFile(file);

//     return null;
//   }
// }
