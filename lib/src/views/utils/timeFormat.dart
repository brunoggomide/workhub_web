import 'package:flutter/services.dart';

class HourTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Filtering for hour format (HH:MM)
    String newString = newValue.text;
    if (newString.length == 2 && oldValue.text.length == 1) {
      newString += ':';
    } else if (newString.length == 2 && oldValue.text.length == 3) {
      newString = newString.substring(0, 1);
    } else if (newString.length > 5) {
      newString = newString.substring(0, 5);
    }

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}
