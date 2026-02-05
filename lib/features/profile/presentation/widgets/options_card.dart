import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/routes/routes.dart';
import 'package:rafiq/core/utils/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/profile/presentation/widgets/profile_editing.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({super.key});

  @override
  Widget build(BuildContext context) {
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
              context.navigateTo(Routes.editScreen);
            },
            icon: SvgManger.person,
            label: "تعديل الملف الشخصي",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () {},
            icon: SvgManger.doc,
            label: "تعديل الملف الطبي",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () {},
            icon: SvgManger.lock,
            label: "تغيير كلمة المرور",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () {},
            icon: SvgManger.logout,
            label: "تسجيل الخروج",
          ),
        ],
      ),
    );
  }
}
