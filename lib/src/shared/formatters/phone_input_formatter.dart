import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Verifica o tamanho máximo do campo.
    if (newValue.text.length > 11) return oldValue;

    final newValueLength = newValue.text.length;

    if (newValueLength == 11) {
      // 0000 = phone debug
      if (newValue.text.toString()[2] != '9' && newValue.text.toString().substring(2, 6) != '0000') {
        return oldValue;
      }
    }

    var cursorPosition = newValue.selection.end;
    var substrIndex = 0;
    final finalValue = StringBuffer();

    if (newValueLength >= 1) {
      finalValue.write('(');
      if (newValue.selection.end >= 1) cursorPosition++;
    }

    if (newValueLength >= 3) {
      finalValue.write('${newValue.text.substring(0, substrIndex = 2)}) ');
      if (newValue.selection.end >= 2) cursorPosition += 2;
    }

    if (newValue.text.length == 11) {
      if (newValueLength >= 8) {
        finalValue.write('${newValue.text.substring(2, substrIndex = 7)}-');
        if (newValue.selection.end >= 7) cursorPosition++;
      }
    } else {
      if (newValueLength >= 7) {
        finalValue.write('${newValue.text.substring(2, substrIndex = 6)}-');
        if (newValue.selection.end >= 6) cursorPosition++;
      }
    }

    if (newValueLength >= substrIndex) {
      finalValue.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: finalValue.toString(),
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
