import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/features/patient_profile/data/models/file_type.dart';

class FileModel {
  final String title;
  final String date;
  final String image;
  final FileType type;
  static List<FileModel> categories = [
    FileModel(
      title: "تحليل دم",
      date: "date",
      image: SvgManger.blood,
      type: FileType.tests,
    ),
    FileModel(
      title: "روشتة طبية",
      date: "date",
      image: SvgManger.prescription,
      type: FileType.scans,
    ),
    FileModel(
      title: "تقرير طبي",
      date: "date",
      image: SvgManger.report,
      type: FileType.reports,
    ),
  ];
  FileModel({
    required this.title,
    required this.date,
    required this.image,
    required this.type,
  });
}
