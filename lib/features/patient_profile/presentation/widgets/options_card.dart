import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_shared_prefs.dart';
import 'package:rafiq/features/patient_profile/presentation/bloc/profile_cubit.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/profile_editing.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return CardWidget(
      verticalPadding: 16.r,
      horizontalPadding: 16.r,
      widget: Column(
        children: [
          ProfileEditing(
            onTap: () {},
            icon: SvgManger.notification,
            label: "الاشعارات",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () {
              context.navigateTo(Routes.editScreen, arguments: cubit);
            },
            icon: SvgManger.person,
            label: "تعديل الملف الشخصي",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () {
              context.navigateTo(
                Routes.editMedicalFileScreen,
                arguments: cubit,
              );
            },
            icon: SvgManger.doc,
            label: "تعديل الملف الطبي",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () {
              context.navigateTo(Routes.changePassword, arguments: cubit);
            },
            icon: SvgManger.lock,
            label: "تغيير كلمة المرور",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () async {
              await AuthSharedPrefs().clearAll();

              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                (route) => false,
              );
            },
            icon: SvgManger.logout,
            label: "تسجيل الخروج",
          ),
        ],
      ),
    );
  }
}
