import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    final digitsOnly = text.replaceAll(RegExp(r'[^0-9]'), '');

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 2 || i == 4) {
        buffer.write('/');
      }
      buffer.write(digitsOnly[i]);
    }

    final newText = buffer.toString();

    if (newText.length == 2 &&
        int.tryParse(newText.substring(0, 2)) != null &&
        int.parse(newText.substring(0, 2)) > 31) {
      return oldValue;
    } else if (newText.length == 5 &&
        int.tryParse(newText.substring(3, 5)) != null &&
        int.parse(newText.substring(3, 5)) > 12) {
      return oldValue;
    } else if (newText.length > 10) {
      return oldValue;
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
