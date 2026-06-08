import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/enums/user_type.dart';
import 'package:rafiq/core/routes/navigation_extension.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';

class GetStart extends StatelessWidget {
  const GetStart({super.key, required this.selectedUserType});
  final UserType? selectedUserType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeightSpace(33),
            Image.asset(
              'assets/images/get_start.png',
              fit: BoxFit.contain,
              height: 474.h,
            ),
            HeightSpace(40),

            CustomButton(
              onPressed: () {
                selectedUserType == UserType.patient
                    ? context.navigateAndReplace('/register')
                    : context.navigateAndReplace('/docRegister');
              },
              text: 'انشاء حساب',
            ),
            HeightSpace(16),
            CustomButton(
              onPressed: () {
                selectedUserType == UserType.patient
                    ? context.navigateAndReplace('/login')
                    : context.navigateAndReplace('/docLogin');
              },
              text: 'لدي حساب بالفعل',
              type: ButtonType.outlined,
              borderWidth: 1.5.w,
            ),
          ],
        ),
      ),
    );
  }
}
