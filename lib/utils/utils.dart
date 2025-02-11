class Utils {
  /// Returns the full path of an image asset.
  static String getImagePath(String name, {String format = 'png'}) {
    if (name.isEmpty) {
      throw ArgumentError('Image name cannot be empty');
    }
    return 'assets/images/$name.$format';
  }
}
