import 'package:rafiq/core/theme/assets_manger.dart';

class FileModel {
  final String title;
  final String date;
  final String image;
  static List<FileModel> categories = [
    FileModel(title: "تحليل دم", date: "date", image: SvgManger.blood),
    FileModel(title: "روشتة طبية", date: "date", image: SvgManger.prescription),
    FileModel(title: "تقرير طبي", date: "date", image: SvgManger.report),
  ];
  FileModel({required this.title, required this.date, required this.image});
}
