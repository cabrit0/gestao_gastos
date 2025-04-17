import 'package:flutter/material.dart';

/// Widget para exibir diálogos de confirmação de forma consistente.
/// 
/// Uso:
/// ```dart
/// ConfirmationDialog.show(
///   context,
///   title: 'Excluir Transação',
///   content: 'Tem certeza que deseja excluir esta transação?',
///   confirmLabel: 'Excluir',
///   onConfirm: () {
///     // Ação a ser executada quando o usuário confirmar
///   },
/// );
/// ```
class ConfirmationDialog {
  /// Exibe um diálogo de confirmação.
  /// 
  /// [context] O contexto do BuildContext.
  /// [title] O título do diálogo.
  /// [content] O conteúdo/mensagem do diálogo.
  /// [confirmLabel] O texto do botão de confirmação (padrão: 'Confirmar').
  /// [cancelLabel] O texto do botão de cancelamento (padrão: 'Cancelar').
  /// [isDestructive] Se a ação é destrutiva, o botão de confirmação será vermelho.
  /// [onConfirm] Callback chamado quando o usuário confirma a ação.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String content,
    String confirmLabel = 'Confirmar',
    String cancelLabel = 'Cancelar',
    bool isDestructive = false,
    required VoidCallback onConfirm,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: Text(cancelLabel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
                onConfirm();
              },
              style: isDestructive
                  ? ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                    )
                  : null,
              child: Text(confirmLabel),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }
}
