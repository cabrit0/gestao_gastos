import 'package:flutter/material.dart';

/// Widget personalizado para AppBar com estilo consistente em toda a aplicação.
///
/// Parâmetros:
/// - title: Título a ser exibido na AppBar
/// - actions: Lista opcional de widgets de ação para a AppBar
/// - showBackButton: Se deve mostrar o botão de voltar (padrão: false)
/// - onBackPressed: Callback opcional quando o botão de voltar é pressionado
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        actions: actions,
        leading:
            showBackButton
                ? IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: colorScheme.primary,
                  ),
                  onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                  tooltip: 'Voltar',
                  style: IconButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                    backgroundColor: colorScheme.primaryContainer.withAlpha(26),
                  ),
                )
                : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
