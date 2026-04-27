import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import 'package:rafiq/core/widgets/spacing_widget.dart';
import 'package:rafiq/features/patient_bookings/presentation/widgets/payment_widgets/payment_method_tile.dart';

class PaymentMethodsSection extends StatefulWidget {
  const PaymentMethodsSection({super.key});

  @override
  State<PaymentMethodsSection> createState() => _PaymentMethodsSectionState();
}

class _PaymentMethodsSectionState extends State<PaymentMethodsSection> {
  int selectedPaymentMethod = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("اختر طريقة الدفع", style: AppTypography.inputLabel),
        const HeightSpace(20),

        PaymentMethodTile(
          title: 'بطاقة بنكية',
          icon: Icons.credit_card_outlined,
          value: 1,
          groupValue: selectedPaymentMethod,
          onChanged: (v) => setState(() => selectedPaymentMethod = v),
        ),

        const HeightSpace(12),

        PaymentMethodTile(
          title: 'الدفع عند الوصول',
          icon: Icons.money_outlined,
          value: 2,
          groupValue: selectedPaymentMethod,
          onChanged: (v) => setState(() => selectedPaymentMethod = v),
        ),
      ],
    );
  }
}
