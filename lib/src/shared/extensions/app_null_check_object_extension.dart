extension AppNullCheckObjectExtension on Object? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
}