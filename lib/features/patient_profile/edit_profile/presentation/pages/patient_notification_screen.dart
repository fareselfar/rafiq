import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/doctor_side/profile_doc/edit_profile_doc/widgets/custom_notification_widget.dart';

class DoctorNotificationScreen extends StatelessWidget {
  const DoctorNotificationScreen.PatientNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("الاشعارات", style: AppTypography.appBarTitelStyle),
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CustomNotificationWidget(
                title1: "تم الغاء موعدك مع د. احمد علي",
                title2:
                    "تم الغاء الموعد بسبب انشغال الدكتور في عملية واليك كود خصم تعويض عن الالغاء كود الخصم : Free30",
                timeTitle: "قبل عشر دقائق",
                icon: SvgManger.calendar,
              ),
              HeightSpace(8),
              CustomNotificationWidget(
                title1: "تم رفع ملف جديد بنجاح",
                title2: "تم اضافه التحليل الى ملفك الطبي",
                timeTitle: "قبل يومين",
                icon: SvgManger.articleNotification,
              ),
              HeightSpace(8),
              CustomNotificationWidget(
                title1: "مقال جديد قد يهمك",
                title2: "تم اضافه مقال جديد افتح صفحة المقالات الان",
                timeTitle: "قبل يوم",
                icon: SvgManger.files,
              ),
              HeightSpace(8),
              CustomNotificationWidget(
                title1: "تم تحديث بيانات الملف الشخصي",
                title2: "تم تعديل رقم الهاتف بنجاح",
                timeTitle: "قبل يومين",
                icon: SvgManger.person,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
