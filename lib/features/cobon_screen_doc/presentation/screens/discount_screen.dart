import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/utils/ui_utils.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/custom_dialog.dart';
import 'package:rafiq/core/widgets/note_widget.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/core/widgets/widgets.dart';
import 'package:rafiq/features/doctor_side/profile_doc/data/models/create_coupon_request.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_cubit.dart';
import 'package:rafiq/features/doctor_side/profile_doc/presentation/bloc/doctor_profile_state.dart';

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
    return BlocListener<DoctorProfileCubit, DoctorProfileState>(
      listener: (context, state) {
        if (state is CouponSuccess) {
          UiUtils.hideDialog(context);

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return CustomDialog();
            },
          );
        }
        if (state is CouponError) {
          UiUtils.hideDialog(context);
          UiUtils.showMessage(
            message: state.message,
            bgColor: Colors.red,
            fgColor: Colors.white,
          );
        }
        if (state is CouponLoading) {
          UiUtils.showLoading(context);
        }
      },
      child: Scaffold(
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
      ),
    );
  }

  void _createCoupon() {
    if (_formKey.currentState!.validate()) {
      // context.read<DoctorProfileCubit>().createCoupon(
      //   request: CreateCouponRequest(
      //     code: _codeController.text,
      //     usageLimit: _nUsersController.text
      //   ),
      // );
    }
  }
}
