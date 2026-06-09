import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/custom_dialog.dart';
import 'package:rafiq/core/widgets/note_widget.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/widgets/widgets.dart';

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({super.key});

  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

final TextEditingController _codeController = TextEditingController();
final TextEditingController _nUsersController = TextEditingController();
GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _DiscountScreenState extends State<DiscountScreen> {
  @override
  void dispose() {
    _codeController.dispose();
    _nUsersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("انشاء كوبون خصم")),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  validator: (value) =>
                      Validators.validateCoupon(_codeController.text),
                  controller: _codeController,
                  label: "الكود",
                  hint: "مثال : KH100",
                  inputStyle: AppTypography.inputTextFormStyle,
                ),
                HeightSpace(16),
                NoteWidget(),
                HeightSpace(16),
                CustomTextField(
                  validator: (value) =>
                      Validators.validateUsers(_nUsersController.text),
                  controller: _nUsersController,
                  label: "عدد المستخدمين",

                  inputStyle: AppTypography.inputTextFormStyle,
                ),
                Spacer(),
                CustomButton(
                  text: "انشاء",
                  onPressed: () {
                    _createCoupon();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createCoupon() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => CustomDialog(title: "تم إنشاء الكوبون بنجاح"),
      );
    }
  }
}
