import 'package:flutter/material.dart';

class BalanceDisplay extends StatelessWidget {
  final String totalBalance;
  final String availableBalance;

  const BalanceDisplay({
    super.key,
    required this.totalBalance,
    required this.availableBalance,
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
                Text(
                  'Saldo Total:',
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  totalBalance,
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
                Text(
                  'Saldo Disponível:',
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  availableBalance,
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

  // Determina a cor do saldo disponível com base no valor
  Color _getAvailableBalanceColor(BuildContext context) {
    // Se o saldo disponível começar com '-', é negativo
    if (availableBalance.startsWith('-')) {
      return Theme.of(context).colorScheme.error;
    }
    // Caso contrário, é positivo ou zero
    return Colors.green;
  }
}
