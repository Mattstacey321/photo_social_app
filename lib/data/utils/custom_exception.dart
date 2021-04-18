class PermissionException implements Exception {
  String errorMessage() {
    return 'Permission not granted';
  }
}
