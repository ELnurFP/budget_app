extension StringX on String {
  String staticallyTyped() {
    return this;
  }
}

extension StringXs on String? {
  String asValidString([String defaultValue = 'N/A']) {
    return this?.isNotEmpty == true ? this! : defaultValue;
  }
}
