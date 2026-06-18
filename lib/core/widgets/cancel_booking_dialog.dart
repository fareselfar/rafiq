import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/custom_button.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_cubit.dart';
import 'package:rafiq/features/patient_bookings/presentation/bloc/appointments_state.dart';
import 'package:rafiq/core/widgets/success_cancel_dialog.dart';

class CancelBookingDialog extends StatelessWidget {
  final int appointmentId;
  const CancelBookingDialog({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<AppointmentsCubit, AppointmentsState>(
      listener: (context, state) {
        if (state is CancelSuccess) {
          Navigator.pop(context);
          context.read<AppointmentsCubit>().loadAppointments();

          showDialog(
            context: context,
            builder: (_) => const SuccessCancelDialog(),
          );
        } else if (state is ActionError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is CancelInProgress;

        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
          backgroundColor: AppColors.backGround,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 49.h, horizontal: 30.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 64.sp,
                  color: AppColors.red,
                ),
                Text(
                  "هل أنت متأكد أنك تريد إلغاء هذا الحجز؟",
                  textAlign: TextAlign.center,
                  style: AppTypography.dialogTitle.copyWith(
                    color: AppColors.red,
                    fontSize: 24.sp,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "لن تتمكن من استرجاعه بعد الإلغاء.",
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyLarge,
                ),
                HeightSpace(40),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: isLoading ? "جاري الإلغاء..." : "تأكيد الإلغاء",
                        type: ButtonType.outlined,
                        onPressed: isLoading
                            ? null
                            : () {
                                context
                                    .read<AppointmentsCubit>()
                                    .cancelAppointment(appointmentId);
                              },
                      ),
                    ),
                    WidthSpace(8),
                    Expanded(
                      child: CustomButton(
                        text: "رجوع",
                        onPressed: isLoading
                            ? null
                            : () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
