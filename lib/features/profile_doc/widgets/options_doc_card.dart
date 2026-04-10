import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/profile/presentation/widgets/card_widget.dart';
import 'package:rafiq/features/profile/presentation/widgets/profile_editing.dart';

class OptionsDocCard extends StatelessWidget {
  const OptionsDocCard({super.key});

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
            onTap: () {},
            icon: SvgManger.person,
            label: "تعديل الملف الشخصي",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () {},
            icon: SvgManger.doc,
            label: "تعديل بيانات العيادة",
          ),
          HeightSpace(23),
          ProfileEditing(
            onTap: () {},
            icon: SvgManger.money,
            label: "الدفع والارباح",
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
