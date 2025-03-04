class TextUtils {
  static String getInitials(String? name) => (name != null && name.isNotEmpty)
      ? name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
      : '';

  // static String getFirstName(String? name) => (name != null && name.isNotEmpty)
  //     ? name.substring(0, name.indexOf(" ").isEven ? name.indexOf(" ") : null)
  //     : '';

  static String getFirstName(String? name) {
    if (name != null && name.isNotEmpty) {
      final spaceIndex = name.indexOf(' ');
      return spaceIndex != -1 ? name.substring(0, spaceIndex) : name;
    } else {
      return '';
    }
  }

  static String getLastName(String? name) {
    if (name != null && name.isNotEmpty && name.split(' ').length > 1) {
      if (name.split(' ')[1].isNotEmpty) {
        return name.split(' ')[1];
      } else {
        return '';
      }
    } else {
      return '';
    }
  }
}
