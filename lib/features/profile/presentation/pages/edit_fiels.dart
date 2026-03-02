import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_search_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/profile/data/models/file_model.dart';
import 'package:rafiq/features/profile/data/models/file_type.dart';
import 'package:rafiq/features/profile/presentation/widgets/classify_files_serach.dart';
import 'package:rafiq/features/profile/presentation/widgets/file_card.dart';
import 'package:rafiq/features/profile/presentation/widgets/small_card.dart';

class EditFiels extends StatefulWidget {
  const EditFiels({super.key});

  @override
  State<EditFiels> createState() => _EditFielsState();
}

class _EditFielsState extends State<EditFiels> {
  FileType selectedType = FileType.all;
  List<FileModel> allFiles = FileModel.categories;
  List<FileModel> filteredFiles = [];

  @override
  void initState() {
    super.initState();
    filteredFiles = allFiles;
  }

  void filterFiles(FileType? type) {
    setState(() {
      selectedType = type ?? FileType.all;

      if (type == FileType.all) {
        filteredFiles = allFiles;
      } else {
        filteredFiles = allFiles.where((file) => file.type == type).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ملفاتي', style: AppTypography.appBarTitelStyle),
        actions: [
          Padding(
            padding: REdgeInsets.only(left: 16),
            child: SmallCard(
              isList: false,
              onTap: () {
                context.navigateTo(Routes.uploadFiels);
              },
              title: "+ رفع ملف ",
              hightPadding: 4,
              widthPadding: 14,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            CustomSearchField(
              hint: 'البحث',
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.filter_list),
            ),
            HeightSpace(20),
            ClassifyFilesSerach(
              selectedType: selectedType,
              onSelect: (type) {
                filterFiles(type);
              },
            ),
            HeightSpace(20),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    FileCard(fileModel: filteredFiles[index]),
                separatorBuilder: (context, index) => HeightSpace(20),
                itemCount: filteredFiles.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
