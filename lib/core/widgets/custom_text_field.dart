import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/theme/app_text_styles.dart';
import '../theme/app_colors.dart';
import 'password_visibility_icon.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String? hint;

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  final TextStyle? inputStyle;
  final TextStyle? hintStyle;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? iconColor;

  final bool isPassword;
  final bool enabled;
  final int maxLines;

  final ValueChanged<String>? onChanged;
  final TextDirection textDirection;

  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final VoidCallback? onFieldSubmitted;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.keyboardType,
    this.validator,
    this.inputStyle,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    this.isPassword = false,
    this.enabled = true,
    this.maxLines = 1,
    this.onChanged,
    this.textDirection = TextDirection.ltr,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofillHints,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  void _togglePassword() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
        ],

        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          autofillHints: widget.autofillHints,
          textDirection: widget.textDirection,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: (_) => widget.onFieldSubmitted?.call(),

          obscureText: widget.isPassword ? _obscure : false,
          maxLines: widget.isPassword ? 1 : widget.maxLines,

          style: widget.inputStyle ?? AppTypography.inputTextFormStyle,

          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surface,

            hintText: widget.hint,
            hintStyle:
                widget.hintStyle ??
                TextStyle(
                  color: AppColors.hintStyle.withOpacity(0.6),
                  fontSize: 14,
                ),

            prefixIcon: widget.prefixIcon,

            // prefixIconConstraints: BoxConstraints(
            //   minWidth: 48.w,
            //   minHeight: 48.h,
            // ),
            suffixIcon: widget.isPassword
                ? PasswordVisibilityIcon(
                    isPasswordHidden: _obscure,
                    toggleVisibility: _togglePassword,
                    iconColor: widget.iconColor ?? AppColors.primary,
                  )
                : widget.suffixIcon,

            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 8.h,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
