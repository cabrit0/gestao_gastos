import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String currencySymbol;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const AmountInput({
    super.key,
    required this.controller,
    this.labelText = 'Quantia',
    this.currencySymbol = '€',
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixText: '$currencySymbol ',
        border: const OutlineInputBorder(),
        hintText: '0.00',
        // Adiciona um ícone monetário
        prefixIcon: Icon(
          Icons.attach_money,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        // Permite apenas dígitos e ponto decimal
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        // Limita a dois dígitos após o ponto decimal
        _DecimalTextInputFormatter(decimalRange: 2),
      ],
      onChanged: onChanged,
      validator: validator ?? _defaultValidator,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  // Validador padrão para garantir que o valor seja um número positivo
  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma quantia';
    }
    
    final double? amount = double.tryParse(value);
    if (amount == null) {
      return 'Por favor, insira um valor numérico válido';
    }
    
    if (amount <= 0) {
      return 'A quantia deve ser maior que zero';
    }
    
    return null;
  }
}

// Formatter personalizado para limitar o número de casas decimais
class _DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalRange;
  
  _DecimalTextInputFormatter({required this.decimalRange});
  
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    
    if (newText.isEmpty) {
      return newValue;
    }
    
    // Verifica se há mais de um ponto decimal
    if (newText.split('.').length > 2) {
      return oldValue;
    }
    
    // Verifica se há mais dígitos após o ponto decimal do que o permitido
    if (newText.contains('.')) {
      final parts = newText.split('.');
      if (parts[1].length > decimalRange) {
        return oldValue;
      }
    }
    
    return newValue;
  }
}
