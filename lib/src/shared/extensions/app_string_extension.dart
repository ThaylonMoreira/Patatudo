import 'package:flutter/material.dart';

import '../formatters/formatters.dart';

extension AppStringExtension on String {
  bool get isEmail {
    final emailRegex = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
    );
    if (emailRegex.hasMatch(this)) return true;
    return false;
  }

  bool get isNumber {
    if (double.tryParse(this) != null) return true;
    return false;
  }

  bool get isAlphabet {
    if (RegExp(r'^[a-zA-Z]+$').hasMatch(this)) return true;
    return false;
  }

  String get parsePhone {
    final formatter = PhoneInputFormatter();
    final phoneFormatted = formatter
        .formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: this),
        )
        .text;

    return phoneFormatted;
  }

  String get removeDiacritics {
    const diacriticsMapping = {
      'á': 'a',
      'à': 'a',
      'â': 'a',
      'ã': 'a',
      'ä': 'a',
      'é': 'e',
      'è': 'e',
      'ê': 'e',
      'ë': 'e',
      'í': 'i',
      'ì': 'i',
      'ï': 'i',
      'ó': 'o',
      'ò': 'o',
      'ô': 'o',
      'õ': 'o',
      'ö': 'o',
      'ú': 'u',
      'ù': 'u',
      'û': 'u',
      'ü': 'u',
      'Á': 'A',
      'À': 'A',
      'Â': 'A',
      'Ã': 'A',
      'Ä': 'A',
      'É': 'E',
      'È': 'E',
      'Ê': 'E',
      'Ë': 'E',
      'Í': 'I',
      'Ì': 'I',
      'Ï': 'I',
      'Ó': 'O',
      'Ò': 'O',
      'Ô': 'O',
      'Õ': 'O',
      'Ö': 'O',
      'Ú': 'U',
      'Ù': 'U',
      'Û': 'U',
      'Ü': 'U',
      'ç': 'c',
      'Ç': 'C',
    };

    return replaceAllMapped(
      RegExp('[À-ž]'),
      (m) => diacriticsMapping[m.group(0)] ?? '',
    );
  }
}
