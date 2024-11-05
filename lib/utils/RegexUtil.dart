import 'package:flutter/services.dart';

class RegexUtil {
  /// 
  static const String regexFirstNotNull = r'^(\S){1}';
}

class RegexFormatter extends TextInputFormatter {
  RegexFormatter({required this.regex});

  /// 
  final String regex;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return TextEditingValue.empty;
    }

    if (!RegExp(regex).hasMatch(newValue.text)) {
      return oldValue;
    }
    return newValue;
  }
}
