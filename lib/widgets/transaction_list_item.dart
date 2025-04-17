import 'package:flutter/material.dart';

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

    // Usar cores do tema para diferenciar despesas e receitas
    final Color amountColor =
        isExpense ? Theme.of(context).colorScheme.error : Colors.green;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      child: ListTile(
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(date, style: Theme.of(context).textTheme.bodySmall),
        leading: CircleAvatar(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(0.8),
          child: Icon(
            isExpense ? Icons.remove : Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
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
