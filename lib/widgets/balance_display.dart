import 'package:flutter/material.dart';

class BalanceDisplay extends StatelessWidget {
  final String currentBalance;
  final String projectedBalance;

  const BalanceDisplay({
    super.key,
    required this.currentBalance,
    required this.projectedBalance,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Tooltip(
                  message:
                      'Saldo atual considerando apenas transações até a data de hoje',
                  child: Text(
                    'Saldo Atual:',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Text(
                  currentBalance,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Tooltip(
                  message:
                      'Saldo projetado considerando todas as transações futuras',
                  child: Text(
                    'Saldo Projetado:',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Text(
                  projectedBalance,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getAvailableBalanceColor(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Determina a cor do saldo projetado com base no valor
  Color _getAvailableBalanceColor(BuildContext context) {
    // Se o saldo projetado começar com '-', é negativo
    if (projectedBalance.startsWith('-')) {
      return Theme.of(context).colorScheme.error;
    }
    // Caso contrário, é positivo ou zero
    return Colors.green;
  }
}
