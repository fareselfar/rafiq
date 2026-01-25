import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ================= PRIMARY =================
  static const Color primary = Color(0xFF468EEC); // لون رفيق
  static const Color primaryVariant = Color(0xFF135BB9); //لون اغمق

  // ================= BACKGROUND =================
  static const Color backGround = Color(0xFFF7FBFF);
  static const Color surface = Color(0xFFFFFFFF); //لون الحاجات اللي فوق الخلفيه

  // ================= TEXT =================
  static const Color textPrimary = Color(0xFF468EEC);
  static const Color textSecondary = Color(0xFF5B5B5B);
  static const Color textDisabled = Color(0xFF9E9E9E);
  static const Color selectedText = Color(0xFF000000);
  static const Color unSelectedText = Color(0xFFC7C7C7);
  static const Color hintStyle = Color(0xFF9E9E9E);
  static const Color textLabel = Color(0xFF000000);
  static const Color inputTextFormStyle = Color(0xFF5B5B5B);
  static const Color textOnPrimary = Colors.white;

  // ================= STATES =================
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFA00505);
  static const Color info = Color(0xFF3B82F6);

  // ================= BORDER =================
  static const Color border = Color(0xFFC7C7C7);
  static const Color divider = Color(0xFF5B5B5B);

  // ================= GRADIENTS (قليلين) =================
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryVariant],
  );

  // ================  الوان تانيه =================
  static const Color selectedDoctor = Color(0xFF00CCBB);
}
