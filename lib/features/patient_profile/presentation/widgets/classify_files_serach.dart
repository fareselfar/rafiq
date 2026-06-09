import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/features/patient_profile/data/models/file_type.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/small_card.dart';

class ClassifyFilesSerach extends StatefulWidget {
  final FileType? selectedType;
  final Function(FileType?) onSelect;

  const ClassifyFilesSerach({
    super.key,
    required this.selectedType,
    required this.onSelect,
  });

  @override
  State<ClassifyFilesSerach> createState() => _ClassifyFilesSerachState();
}

class _ClassifyFilesSerachState extends State<ClassifyFilesSerach> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...FileType.values.map((type) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: buildCard(type.displayName, type),
            );
          }),
        ],
      ),
    );
  }

  Widget buildCard(String title, FileType? type) {
    final isSelected = widget.selectedType == type;

    return SmallCard(
      isList: true,
      title: title,
      hightPadding: 8,
      widthPadding: 20,
      bgColor: isSelected ? AppColors.primary : AppColors.surface,
      fgColor: isSelected ? Colors.white : AppColors.textSecondary,
      onTap: () => widget.onSelect(type),
    );
  }
}
//.toList()