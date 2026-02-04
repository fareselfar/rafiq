import 'package:flutter/widgets.dart';

extension NavigationExtension on BuildContext {
  /// Navigator.pushNamed
  void navigateTo(String routeName, {Object? arguments}) {
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  /// Navigator.pushReplacementNamed
  /// Replaces the current route by pushing the given route and then disposing the previous route once the new route has finished animating in.
  void navigateAndReplace(String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(this, routeName, arguments: arguments);
  }

  /// Navigator.pushNamedAndRemoveUntil
  /// Push the given route onto the navigator, and then remove all the previous routes until the predicate returns true.
  void navigateAndRemoveUntil(String routeName, {Object? arguments}) {
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
