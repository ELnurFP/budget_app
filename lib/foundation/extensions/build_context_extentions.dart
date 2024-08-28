import 'package:flutter/material.dart';
import 'package:home_budget_app/budget_app.dart';

extension BuildContextX on BuildContext {
  Size get _size => MediaQuery.sizeOf(this);
  double get width => _size.width;
  double get height => _size.height;

  bool get isMobile => width < 1024.0;
  bool get isDesktop => width >= 1024.0;

  ThemeData get theme => Theme.of(this);
  Color get primaryColor => primary;
}
