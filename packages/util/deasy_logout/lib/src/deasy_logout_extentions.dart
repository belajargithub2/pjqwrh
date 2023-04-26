extension DeasyLogoutExtention on String {
  bool isContainIgnoreCase(String value) {
    return this
        .toEmptyIfNull()
        .toLowerCase()
        .contains(value.toEmptyIfNull().toLowerCase());
  }

  String toEmptyIfNull() {
    if (this == null) {
      return "";
    } else {
      return this;
    }
  }
}
