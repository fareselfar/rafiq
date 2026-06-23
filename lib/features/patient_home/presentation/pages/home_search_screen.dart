import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_search_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctors/presentation/widgets/doctor_search/doctor_card/doctor_card.dart';
import 'package:rafiq/features/patient_home/presentation/bloc/home_cubit.dart';
import 'package:rafiq/features/patient_home/presentation/widgets/custom_home_search_widget.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({super.key});

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> {
  final TextEditingController searchController = TextEditingController();

  bool isSearching = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('البحث'),
        backgroundColor: AppColors.surface,
        leadingWidth: 30.w,
        iconTheme: const IconThemeData(size: 33),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            CustomSearchField(
              controller: searchController,
              hint: 'البحث',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.filter_list),
              onChanged: (value) {
                setState(() {
                  isSearching = value.trim().isNotEmpty;
                });

                if (value.trim().isNotEmpty) {
                  context.read<SearchCubit>().search(value);
                }
              },
            ),

            HeightSpace(10),

            Expanded(
              child: searchController.text.isEmpty
                  ? const CustomHomeSearchWidget()
                  : BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        if (state is SearchLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is SearchLoaded) {
                          if (state.doctors.isEmpty) {
                            return const Center(child: Text('لا توجد نتائج'));
                          }

                          return ListView.builder(
                            itemCount: state.doctors.length,
                            itemBuilder: (context, index) {
                              final doctor = state.doctors[index];

                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                // child: DoctorCard(
                                //   doctorName: doctor.name,
                                //   specialization:
                                //       doctor.specialization ?? '',
                                //   rating: doctor.rate,
                                //   image: doctor.imagePath,
                                // ),
                              );
                            },
                          );
                        }

                        if (state is SearchError) {
                          return Center(child: Text(state.message));
                        }

                        return const SizedBox();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
