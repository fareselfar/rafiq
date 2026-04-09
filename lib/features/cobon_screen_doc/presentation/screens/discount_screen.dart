import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/widgets/widgets.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("انشاء كوبون خصم")),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              CustomTextField(
                label: "الكود",
                hint: "مثال : KH100",
                inputStyle: AppTypography.inputTextFormStyle,
              ),
              HeightSpace(16),
              HeightSpace(16),
              CustomTextField(
                label: "عدد المستخدمين",

                inputStyle: AppTypography.inputTextFormStyle,
              ),
              Spacer(),
              CustomButton(text: "انشاء", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
