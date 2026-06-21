import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_search_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_profile/data/models/file_model.dart';
import 'package:rafiq/features/patient_profile/data/models/file_type.dart';
import 'package:rafiq/features/patient_profile/data/models/medical_file_response.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_cubit.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_state.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/classify_files_serach.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/file_card.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/small_card.dart';

class MedicalFiels extends StatefulWidget {
  const MedicalFiels({super.key});

  @override
  State<MedicalFiels> createState() => _MedicalFielsState();
}

class _MedicalFielsState extends State<MedicalFiels> {
  final TextEditingController searchController = TextEditingController();

  List<MedicalFileResponse> allFiles = [];
  List<MedicalFileResponse> filteredFiles = [];
  FileType selectedType = FileType.all;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getFiles();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterFiles(FileType? type) {
    setState(() {
      selectedType = type ?? FileType.all;
    });
    if (selectedType == FileType.all) {
      filteredFiles = List.from(allFiles);
    } else {
      filteredFiles = allFiles.where((file) {
        return file.fileType == selectedType.name;
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is FilesListLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FilesListError) {
          return Text(state.message);
        }
        if (state is FilesListLoaded) {
          if (allFiles.isEmpty) {
            allFiles = state.files;
            filteredFiles = state.files;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('ملفاتي', style: AppTypography.appBarTitelStyle),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<ProfileCubit>().getProfile();
                  Navigator.pop(context);
                },
              ),
              actions: [
                Padding(
                  padding: REdgeInsets.only(left: 16),
                  child: SmallCard(
                    isList: false,
                    onTap: () {
                      context.navigateTo(Routes.uploadFiels, arguments: cubit);
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
                    onChanged: (value) {
                      if (value.trim().isNotEmpty) {
                        searchFiles(value);
                      }
                    },
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
                      itemBuilder: (context, index) {
                        final file = filteredFiles[index];

                        return FileCard(
                          fileModel: FileModel(
                            title: file.title,
                            date: file.formattedDate,
                            notes: file.notes,
                            fileType: file.fileType,
                          ),
                          selectedType: selectedType,
                        );
                      },
                      separatorBuilder: (context, index) => HeightSpace(20),
                      itemCount: filteredFiles.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  void searchFiles(String query) {
    setState(() {
      filteredFiles = allFiles
          .where(
            (file) => file.title.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }
}
