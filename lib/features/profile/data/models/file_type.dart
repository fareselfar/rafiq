enum FileType { all, tests, scans, reports }

extension FileTypeExtension on FileType {
  String get displayName {
    switch (this) {
      case FileType.all:
        return "الكل";
      case FileType.tests:
        return "تحاليل";
      case FileType.scans:
        return "أشعة";
      case FileType.reports:
        return "تقارير";
    }
  }
}
