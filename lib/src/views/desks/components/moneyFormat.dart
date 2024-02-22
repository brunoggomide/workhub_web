import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoneyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Removendo caracteres não numéricos
    int intValue =
        int.tryParse(newValue.text.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;

    // Formatando para o padrão brasileiro
    final formattedValue = NumberFormat.currency(locale: 'pt_BR', symbol: '')
        .format(intValue / 100.0);

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
