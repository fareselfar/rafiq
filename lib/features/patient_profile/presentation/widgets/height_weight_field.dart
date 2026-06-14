import 'package:flutter/material.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';

class HeightWeightField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const HeightWeightField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: label,
        hint: hint,
        controller: controller,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
