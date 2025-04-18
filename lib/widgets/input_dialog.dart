import 'package:flutter/material.dart';

/// Widget reutilizável para diálogos que necessitam de entrada de dados.
///
/// Exibe um diálogo com um campo de texto e botões de cancelar e confirmar.
class InputDialog extends StatefulWidget {
  final String title;
  final String labelText;
  final String? initialValue;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String) onConfirm;
  final String confirmLabel;
  final String cancelLabel;

  const InputDialog({
    super.key,
    required this.title,
    required this.labelText,
    this.initialValue,
    this.keyboardType = TextInputType.number,
    this.validator,
    required this.onConfirm,
    this.confirmLabel = 'Guardar',
    this.cancelLabel = 'Cancelar',
  });

  @override
  State<InputDialog> createState() => _InputDialogState();

  /// Exibe um diálogo de entrada de dados.
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String labelText,
    String? initialValue,
    TextInputType keyboardType = TextInputType.number,
    String? Function(String?)? validator,
    required Function(String) onConfirm,
    String confirmLabel = 'Guardar',
    String cancelLabel = 'Cancelar',
  }) {
    return showDialog(
      context: context,
      builder:
          (context) => InputDialog(
            title: title,
            labelText: labelText,
            initialValue: initialValue,
            keyboardType: keyboardType,
            validator: validator,
            onConfirm: onConfirm,
            confirmLabel: confirmLabel,
            cancelLabel: cancelLabel,
          ),
    );
  }
}

class _InputDialogState extends State<InputDialog> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            labelText: widget.labelText,
            border: const OutlineInputBorder(),
          ),
          validator: widget.validator,
          autofocus: true,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(widget.cancelLabel),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final value = _controller.text;
              Navigator.of(context).pop();
              widget.onConfirm(value);
            }
          },
          child: Text(widget.confirmLabel),
        ),
      ],
    );
  }
}
