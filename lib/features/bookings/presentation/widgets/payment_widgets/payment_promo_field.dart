import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';

class PaymentPromoField extends StatelessWidget {
  const PaymentPromoField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: 'برومو كود',
      hint: 'مثال: FREE100',
      prefixIcon: const Icon(
        Icons.local_offer_outlined,
        color: AppColors.textDisabled,
      ),
    );
  }
}
