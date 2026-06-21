import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/authentication/data/datasources/local/auth_shared_prefs.dart';
import 'package:rafiq/features/doctor_side/profile_doc/domain/entity/Profile_doctor_entity.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_cubit.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_state.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/patient_profile/presentation/widgets/profile_editing.dart';

class OptionsDocCard extends StatelessWidget {
  const OptionsDocCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorProfileCubit>();
    DoctorProfileEntity? profile;
    if (cubit.state is DoctorProfileLoaded) {
      profile = (cubit.state as DoctorProfileLoaded).profile;
    }
    return CardWidget(
      verticalPadding: 16.r,
      horizontalPadding: 16.r,
      widget: Column(
        children: [
          ProfileEditing(
            onTap: () {
              context.navigateTo(Routes.doctorNotificationScreen);
            },
            icon: SvgManger.notification,
            label: "الاشعارات",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () {
              context.navigateTo(
                Routes.editDocProfile,
                arguments: {'profile': profile, 'cubit': cubit},
              );
            },
            icon: SvgManger.person,
            label: "تعديل الملف الشخصي",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () {
              context.navigateTo(Routes.editDocClinic, arguments: cubit);
            },
            icon: SvgManger.doc,
            label: "تعديل بيانات العيادة",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () {
              context.navigateTo(Routes.paymentInfo, arguments: cubit);
            },
            icon: SvgManger.money,
            label: "الدفع والارباح",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () {
              context.navigateTo(Routes.changeDocPassword, arguments: cubit);
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
