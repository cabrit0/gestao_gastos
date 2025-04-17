import 'package:flutter/material.dart';
import 'transaction_screen.dart';
import '../widgets/transaction_list_item.dart';
import '../widgets/balance_display.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_field.dart';
import '../widgets/empty_state_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _hasTransactions = true; // Controla se há transações para exibir
  String _searchQuery = ''; // Armazena o texto de pesquisa atual

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Simula a filtragem de transações (será implementado com dados reais posteriormente)
  void _filterTransactions(String query) {
    setState(() {
      _searchQuery = query;
      // Simulação: se a pesquisa não estiver vazia e não corresponder a nenhuma transação
      _hasTransactions =
          query.isEmpty ||
          'supermercado'.contains(query.toLowerCase()) ||
          'combustível'.contains(query.toLowerCase()) ||
          'salário'.contains(query.toLowerCase());
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Gestor de Gastos',
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            style: IconButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primaryContainer.withAlpha(26),
            ),
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
              child: SearchField(
                controller: _searchController,
                hintText: 'Filtrar transações...',
                labelText: 'Filtrar',
                onChanged: _filterTransactions,
              ),
            ),
            Expanded(
              child:
                  _hasTransactions
                      ? ListView(
                        children: [
                          TransactionListItem(
                            title: 'Supermercado',
                            amount: '-€45.00',
                            date: '15/04/2024',
                            onEditTap: () {
                              // Navegar para a tela de edição (implementação futura)
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Editar Supermercado'),
                                ),
                              );
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
                                    const SnackBar(
                                      content: Text('Transação excluída'),
                                    ),
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
                              // Navegar para a tela de edição (implementação futura)
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Editar Combustível'),
                                ),
                              );
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
                                    const SnackBar(
                                      content: Text('Transação excluída'),
                                    ),
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
                              // Navegar para a tela de edição (implementação futura)
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Editar Salário')),
                              );
                            },
                            onDeleteTap: () {
                              ConfirmationDialog.show(
                                context,
                                title: 'Excluir Transação',
                                content:
                                    'Tem certeza que deseja excluir "Salário"?',
                                confirmLabel: 'Excluir',
                                isDestructive: true,
                                onConfirm: () {
                                  // Aqui seria implementada a lógica para excluir a transação
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Transação excluída'),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      )
                      : EmptyStateWidget(
                        icon: Icons.receipt_long,
                        message: 'Nenhuma transação encontrada',
                        subMessage:
                            _searchQuery.isNotEmpty
                                ? 'Tente usar outros termos de pesquisa'
                                : 'Adicione sua primeira transação usando o botão abaixo',
                        actionLabel: 'Adicionar Transação',
                        onAction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const TransactionScreen(isEditing: false),
                            ),
                          );
                        },
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
