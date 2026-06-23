import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/data_formate.dart';
import 'package:rafiq/core/utils/validators.dart';
import 'package:rafiq/core/widgets/custom_text_form_field.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({super.key, required this.controller, this.hint});
  final TextEditingController controller;
  final String? hint;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (picked != null) {
          controller.text = FormateDate.formatTimeForApi(picked);
        }
      },
      child: AbsorbPointer(
        child: CustomTextField(
          controller: controller,
          hint: hint ?? '',
          suffixIcon: const Icon(Icons.access_time),
          validator: (value) => Validators.required(value),
        ),
      ),
    );
  }
}
