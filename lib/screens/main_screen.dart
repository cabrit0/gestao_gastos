import 'package:flutter/material.dart';
import 'transaction_screen.dart';
import '../widgets/transaction_list_item.dart';
import '../widgets/balance_display.dart';
import '../widgets/confirmation_dialog.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Gastos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () {
              // Futuro diálogo para editar saldo
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BalanceDisplay(
              totalBalance: '€ 1000.00',
              availableBalance: '€ 500.50',
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Filtrar...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  TransactionListItem(
                    title: 'Supermercado',
                    amount: '-€45.00',
                    date: '15/04/2024',
                    onEditTap: () {
                      print('Editar Supermercado');
                    },
                    onDeleteTap: () {
                      ConfirmationDialog.show(
                        context,
                        title: 'Excluir Transação',
                        content:
                            'Tem certeza que deseja excluir "Supermercado"?',
                        confirmLabel: 'Excluir',
                        isDestructive: true,
                        onConfirm: () {
                          // Aqui seria implementada a lógica para excluir a transação
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Transação excluída')),
                          );
                        },
                      );
                    },
                  ),
                  TransactionListItem(
                    title: 'Combustível',
                    amount: '-€35.50',
                    date: '12/04/2024',
                    onEditTap: () {
                      print('Editar Combustível');
                    },
                    onDeleteTap: () {
                      ConfirmationDialog.show(
                        context,
                        title: 'Excluir Transação',
                        content:
                            'Tem certeza que deseja excluir "Combustível"?',
                        confirmLabel: 'Excluir',
                        isDestructive: true,
                        onConfirm: () {
                          // Aqui seria implementada a lógica para excluir a transação
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Transação excluída')),
                          );
                        },
                      );
                    },
                  ),
                  TransactionListItem(
                    title: 'Salário',
                    amount: '+€1200.00',
                    date: '01/04/2024',
                    onEditTap: () {
                      print('Editar Salário');
                    },
                    onDeleteTap: () {
                      ConfirmationDialog.show(
                        context,
                        title: 'Excluir Transação',
                        content: 'Tem certeza que deseja excluir "Salário"?',
                        confirmLabel: 'Excluir',
                        isDestructive: true,
                        onConfirm: () {
                          // Aqui seria implementada a lógica para excluir a transação
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Transação excluída')),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TransactionScreen(isEditing: false),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
