import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/features/specialization/presentation/bloc/specialization_cubit.dart';
import 'package:rafiq/features/specialization/presentation/bloc/specialization_state.dart';
import 'package:rafiq/features/specialization/presentation/widgets/specialization_widget.dart';

class SpecializationsScreen extends StatefulWidget {
  const SpecializationsScreen({super.key});

  @override
  State<SpecializationsScreen> createState() => _SpecializationsScreenState();
}

class _SpecializationsScreenState extends State<SpecializationsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SpecializationCubit>().getSpecializations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: Text('التخصصات'),
      ),
      body: BlocBuilder<SpecializationCubit, SpecializationState>(
        builder: (context, state) {
          if (state is SpecializationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SpecializationError) {
            return Center(child: Text(state.message));
          }
          if (state is SpecializationLoaded) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .78,
              ),
              itemCount: state.specializations.length,
              itemBuilder: (context, index) {
                final specialization = state.specializations[index];
                return SpecializationWidget(
                  specializationEntity: specialization,
                  onTap: () {
                    context.navigateTo(
                      Routes.homeSearchScreen,
                      arguments: specialization.name,
                    );
                  },
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}