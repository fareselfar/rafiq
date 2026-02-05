/// Form Validators
/// توفر وظائف التحقق من صحة حقول الإدخال الشائعة
class Validators {
  Validators._();

  /// التحقق مما إذا كان الحقل فارغاً
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return 'حقل ${fieldName ?? "الإدخال"} مطلوب';
    }
    return null;
  }

  /// التحقق من صيغة البريد الإلكتروني
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'يرجى إدخال بريد إلكتروني صحيح';
    }

    return null;
  }

  /// التحقق من قوة كلمة المرور
  static String? password(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (value.length < minLength) {
      return 'يجب أن تتكون كلمة المرور من $minLength أحرف على الأقل';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'يجب أن تحتوي على حرف كبير واحد على الأقل';
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'يجب أن تحتوي على حرف صغير واحد على الأقل';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'يجب أن تحتوي على رقم واحد على الأقل';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'يجب أن تحتوي على رمز خاص واحد على الأقل';
    }

    return null;
  }

  /// التحقق من تطابق كلمات المرور
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'يرجى تأكيد كلمة المرور';
    }

    if (value != password) {
      return 'كلمات المرور غير متطابقة';
    }

    return null;
  }

  /// التحقق من رقم الهاتف
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    }

    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

    if (!phoneRegex.hasMatch(value.replaceAll(RegExp(r'[\s-]'), ''))) {
      return 'يرجى إدخال رقم هاتف صحيح';
    }

    return null;
  }

  /// التحقق من الحد الأدنى للطول
  static String? minLength(String? value, int length, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return 'حقل ${fieldName ?? "الإدخال"} مطلوب';
    }

    if (value.length < length) {
      return 'يجب أن يكون ${fieldName ?? "هذا الحقل"} بطول $length أحرف على الأقل';
    }

    return null;
  }

  static String? emailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'البريد الإلكتروني أو رقم الهاتف مطلوب';
    }

    // Regex للإيميل
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    // Regex لرقم الهاتف (يقبل من 10 لـ 15 رقم)
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

    // بنختبر القيمة: لو هي مش إيميل "و" مش رقم تليفون، يبقى فيه غلط
    if (!emailRegex.hasMatch(value) &&
        !phoneRegex.hasMatch(value.replaceAll(RegExp(r'[\s-]'), ''))) {
      return 'يرجى إدخال بريد إلكتروني أو رقم هاتف صحيح';
    }

    return null;
  }

  /// التحقق من صحة التاريخ (dd/MM/yyyy)
  static String? date(String? value) {
    if (value == null || value.isEmpty) {
      return 'التاريخ مطلوب';
    }

    final dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');

    if (!dateRegex.hasMatch(value)) {
      return 'يرجى إدخال التاريخ بصيغة يوم/شهر/سنة';
    }

    final parts = value.split('/');
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);

    if (month == null || month < 1 || month > 12) return 'شهر غير صحيح';
    if (day == null || day < 1 || day > 31) return 'يوم غير صحيح';

    return null;
  }

  /// دمج أكثر من محقق
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }
}
