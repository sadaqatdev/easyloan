class StringUtil {
  // 
  static bool isEmail(String input) {
    String regexEmail =
        "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
    // String regexEmail = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" +
    //     "\\@" +
    //     "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
    //     "(" +
    //     "\\." +
    //     "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
    //     ")+";
    if (input == null || input.isEmpty) return false;
    return new RegExp(regexEmail).hasMatch(input);
  }

  // 
  static final String DIGIT_REGEX = "[0-9]+";

  // 
  static final String CONTAIN_DIGIT_REGEX = ".*[0-9].*";

  // 
  static final String LETTER_REGEX = "[a-zA-Z]+";

  // 
  static final String SMALL_CONTAIN_LETTER_REGEX = ".*[a-z].*";

  // 
  static final String BIG_CONTAIN_LETTER_REGEX = ".*[A-Z].*";

  // 
  static final String CONTAIN_LETTER_REGEX = ".*[a-zA-Z].*";

  // 
  static final String CHINESE_REGEX = "[\u4e00-\u9fa5]";

  // 
  static final String LETTER_DIGIT_REGEX = "^[a-z0-9A-Z]+\$";
  static final String CHINESE_LETTER_REGEX = "([\u4e00-\u9fa5]+|[a-zA-Z]+)";
  static final String CHINESE_LETTER_DIGIT_REGEX =
      "^[a-z0-9A-Z\u4e00-\u9fa5]+\$";

  // 
  static bool isOnly(String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp(DIGIT_REGEX).hasMatch(input);
  }

  // 
  static bool hasDigit(String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp(CONTAIN_DIGIT_REGEX).hasMatch(input);
  }

  // 
  static bool isChinese(String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp(CHINESE_REGEX).hasMatch(input);
  }
}
