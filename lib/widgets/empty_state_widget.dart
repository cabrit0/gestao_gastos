import 'package:flutter/material.dart';

/// Widget reutilizável para exibir um estado vazio de forma amigável.
///
/// Exibe um ícone, uma mensagem principal, uma mensagem secundária opcional
/// e um botão de ação opcional. Utiliza o tema da aplicação para manter
/// a consistência visual.
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? subMessage;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyStateWidget({
    super.key,
    this.icon = Icons.inbox_rounded,
    required this.message,
    this.subMessage,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícone
            Icon(
              icon,
              size: 80,
              color: colorScheme.primary.withAlpha((0.7 * 255).round()),
            ),
            const SizedBox(height: 24),

            // Mensagem principal
            Text(
              message,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            // Mensagem secundária (opcional)
            if (subMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                subMessage!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // Botão de ação (opcional)
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              Tooltip(
                message: actionLabel!,
                child: FloatingActionButton(
                  onPressed: onAction,
                  child: const Icon(Icons.add_card),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
