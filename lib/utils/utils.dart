class Utils {

  /// Returns the path to an image asset based on the given name and format (defaults to 'png').
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

}