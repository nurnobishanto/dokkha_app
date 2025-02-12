class AssetImagePaths {
  static const String base = 'assets/images/';

  /// Returns the full path of an image asset.
  static String getFullPath(String name, {String format = 'png'}) {
    return '$base$name.$format';
  }

  /// Specific image path constants
  static String get appIcon => getFullPath('app_icon');
  static String get newImage => getFullPath('new_image');
}
