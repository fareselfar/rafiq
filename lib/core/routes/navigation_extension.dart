import 'package:flutter/widgets.dart';

extension NavigationExtension on BuildContext {

  /// Navigator.pushNamed
  void navigateTo(
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pushNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  /// Navigator.pushReplacementNamed
  void navigateAndReplace(
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pushReplacementNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  /// Navigator.pushNamedAndRemoveUntil
  void navigateAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) {
    Navigator.pushNamedAndRemoveUntil(
      this,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Navigator.pop
  void goBack() {
    if (Navigator.canPop(this)) {
      Navigator.pop(this);
    }
  }
}
