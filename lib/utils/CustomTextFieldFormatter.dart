import 'package:flutter/services.dart';

class CustomTextFieldFormatter extends TextInputFormatter {

  static const defaultDouble = 0.001;

  ///，-1，-1
  int digit;
  //，
  CustomTextFieldFormatter({this.digit = -1});


  static double strToFloat(String str, [double defaultValue = defaultDouble]) {
    try {
      return double.parse(str);
    } catch (e) {
      return defaultValue;
    }
  }

  ///
  static int getValueDigit(String value) {
    if (value.contains(".")) {
      return value.split(".")[1].length;
    } else {
      return -1;
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    // .0.
    if (value == ".") {
      value = "0.";
      selectionIndex++;
      // -，，，-
    } else if (value == "-") {
      value = "-";
      selectionIndex++;
      // ，0.001
    } else if (value != "" && value != defaultDouble.toString() && strToFloat(value, defaultDouble) == defaultDouble || getValueDigit(value) > digit) {
      value = oldValue.text;
      selectionIndex = oldValue.selection.end;
    }
    // ，
    return new TextEditingValue(
      text: value,
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}