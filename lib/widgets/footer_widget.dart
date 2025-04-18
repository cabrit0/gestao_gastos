import 'package:flutter/material.dart';

/// Widget de footer discreto para a aplicação.
/// 
/// Exibe uma mensagem de crédito com estilo sutil.
class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Center(
        child: Text(
          'Codificado com ❤️ por cabrit0',
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(102), // 0.4 * 255 = 102
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
