import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TransactionListItem extends StatelessWidget {
  final String title;
  final String amount;
  final String date;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  const TransactionListItem({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determinar se é uma despesa (valor negativo) ou receita (valor positivo)
    final bool isExpense = amount.startsWith('-');

    // Usar cores específicas para diferenciar despesas e receitas
    final Color amountColor =
        isExpense ? AppTheme.expenseColor : AppTheme.incomeColor;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      child: ListTile(
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(date, style: Theme.of(context).textTheme.bodySmall),
        leading: CircleAvatar(
          backgroundColor:
              isExpense
                  ? AppTheme.expenseColor.withAlpha(204) // 0.8 * 255 = 204
                  : AppTheme.incomeColor.withAlpha(204),
          child: Icon(
            isExpense
                ? Icons.arrow_downward_rounded
                : Icons.arrow_upward_rounded,
            color: Colors.white,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              amount,
              style: TextStyle(fontWeight: FontWeight.bold, color: amountColor),
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: onEditTap,
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
              onPressed: onDeleteTap,
            ),
          ],
        ),
      ),
    );
  }
}
