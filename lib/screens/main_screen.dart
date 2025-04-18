import 'package:flutter/material.dart';
import 'transaction_screen.dart';
import '../widgets/transaction_list_item.dart';
import '../widgets/balance_display.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_field.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/input_dialog.dart';
import '../models/transacao.dart';
import '../helpers/storage_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Controllers
  final TextEditingController _searchController = TextEditingController();

  // Dados
  List<Transacao> _allTransactions = [];
  List<Transacao> _filteredTransactions = [];
  double _initialBalance = 0.0; // Saldo inicial definido pelo usuário
  double _currentBalance = 0.0; // Saldo atual (considera transações até hoje)
  double _projectedBalance =
      0.0; // Saldo projetado (considera todas as transações)

  // Estados
  bool _isLoading = true;
  bool _hasTransactions = true; // Controla se há transações para exibir
  String _searchQuery = ''; // Armazena o texto de pesquisa atual

  @override
  void initState() {
    super.initState();

    // Adicionar listener ao controller de pesquisa
    _searchController.addListener(() {
      _filterTransactions(_searchController.text);
    });

    // Carregar dados iniciais
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Carrega os dados do armazenamento
  Future<void> _loadData() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Carregar dados do StorageHelper
      _initialBalance = await StorageHelper.loadInitialBalance();
      _allTransactions = await StorageHelper.loadTransactions();

      // Data atual para comparação
      final now = DateTime.now();
      final today = DateTime(
        now.year,
        now.month,
        now.day,
      ); // Apenas a data, sem hora

      // Filtrar transações passadas e presentes (até hoje)
      final pastOrPresentTransactions =
          _allTransactions.where((tx) => !tx.data.isAfter(today)).toList();

      // Filtrar transações futuras (após hoje)
      final futureTransactions =
          _allTransactions.where((tx) => tx.data.isAfter(today)).toList();

      // Calcular saldo atual (considera apenas transações até hoje)
      final somaPastOrPresent = pastOrPresentTransactions.fold(
        0.0,
        (sum, tx) => sum + tx.quantia,
      );
      _currentBalance = _initialBalance + somaPastOrPresent;

      // Calcular saldo projetado (considera todas as transações)
      final somaFuture = futureTransactions.fold(
        0.0,
        (sum, tx) => sum + tx.quantia,
      );
      _projectedBalance = _currentBalance + somaFuture;

      // Inicializar transações filtradas com todas as transações
      _filteredTransactions = List.from(_allTransactions);

      // Atualizar estado de _hasTransactions
      _hasTransactions = _filteredTransactions.isNotEmpty;
    } catch (e) {
      // Usar um logger seria melhor em produção
      debugPrint('Erro ao carregar dados: $e');
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Filtra as transações com base no texto de pesquisa
  void _filterTransactions(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();

      if (query.isEmpty) {
        // Se a pesquisa estiver vazia, mostrar todas as transações
        _filteredTransactions = List.from(_allTransactions);
      } else {
        // Filtrar transações que contenham o texto de pesquisa no título
        _filteredTransactions =
            _allTransactions
                .where((tx) => tx.titulo.toLowerCase().contains(_searchQuery))
                .toList();
      }

      // Atualizar estado de _hasTransactions
      _hasTransactions = _filteredTransactions.isNotEmpty;
    });
  }

  // Variável para armazenar a referência do SnackBar atual
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? _currentSnackBar;

  // Método para mostrar SnackBar cancelando o anterior se existir
  void _showSnackBar(String message) {
    // Fecha o SnackBar atual se existir
    _currentSnackBar?.close();

    // Mostra o novo SnackBar e armazena sua referência
    _currentSnackBar = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Método para editar uma transação
  Future<void> _editTransaction(Transacao transaction) async {
    // Navegar para a tela de edição passando a transação existente
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => TransactionScreen(existingTransaction: transaction),
      ),
    );

    // Se o resultado for true, recarregar os dados
    if (result == true && mounted) {
      _loadData();
    }
  }

  // Método para excluir uma transação
  Future<void> _deleteTransaction(String id) async {
    ConfirmationDialog.show(
      context,
      title: 'Excluir Transação',
      content: 'Tem certeza que deseja excluir esta transação?',
      confirmLabel: 'Excluir',
      isDestructive: true,
      onConfirm: () async {
        try {
          // Carregar transações atuais
          List<Transacao> transactions = await StorageHelper.loadTransactions();

          // Verificar se há transações
          if (transactions.isEmpty) {
            if (mounted) {
              _showSnackBar('Não há transações para excluir');
            }
            return;
          }

          // Verificar se a transação existe
          final index = transactions.indexWhere((tx) => tx.id == id);
          if (index == -1) {
            if (mounted) {
              _showSnackBar('Transação não encontrada');
            }
            return;
          }

          // Remover a transação com o ID correspondente
          transactions.removeWhere((tx) => tx.id == id);

          // Salvar a lista atualizada
          await StorageHelper.saveTransactions(transactions);

          // Recarregar dados
          if (mounted) {
            _loadData();
            _showSnackBar('Transação excluída');
          }
        } catch (e) {
          if (mounted) {
            _showSnackBar('Erro ao excluir transação: $e');
          }
        }
      },
    );
  }

  // Método para mostrar diálogo de edição do saldo inicial
  void _showEditInitialBalanceDialog() {
    if (!mounted) return;

    InputDialog.show(
      context: context,
      title: 'Editar Saldo Inicial',
      labelText: 'Saldo Inicial',
      initialValue: _initialBalance.toString(),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um valor';
        }
        if (double.tryParse(value) == null) {
          return 'Por favor, insira um valor numérico válido';
        }
        return null;
      },
      onConfirm: (value) {
        // Verificar se o widget ainda está montado antes de continuar
        if (!mounted) return;

        final newBalance = double.tryParse(value);
        if (newBalance != null) {
          // Usar um Future.microtask para garantir que o diálogo seja fechado completamente
          Future.microtask(() async {
            try {
              await StorageHelper.saveInitialBalance(newBalance);
              _initialBalance = newBalance; // Atualizar o saldo inicial
              if (mounted) {
                _loadData();
                _showSnackBar('Saldo inicial atualizado');
              }
            } catch (e) {
              if (mounted) {
                _showSnackBar('Erro ao salvar saldo: $e');
              }
            }
          });
        }
      },
    );
  }

  // Método para navegar para a tela de adicionar transação
  Future<void> _navigateToAddTransaction() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TransactionScreen()),
    );

    // Se o resultado for true, recarregar os dados
    if (result == true && mounted) {
      _loadData();
    }
  }

  // Método para limpar todos os dados armazenados
  Future<void> _clearAllData() async {
    // Mostrar diálogo de confirmação
    ConfirmationDialog.show(
      context,
      title: 'Limpar Todos os Dados',
      content:
          'Tem certeza que deseja limpar todos os dados? Esta ação não pode ser desfeita.',
      confirmLabel: 'Limpar',
      isDestructive: true,
      onConfirm: () async {
        try {
          // Limpar todos os dados
          await StorageHelper.clearAllData();

          // Recarregar dados
          if (mounted) {
            _loadData();
            _showSnackBar('Todos os dados foram limpos com sucesso');
          }
        } catch (e) {
          if (mounted) {
            _showSnackBar('Erro ao limpar dados: $e');
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CustomAppBar(
        title: 'Gestor de Gastos',
        actions: [
          // Botão para editar o saldo inicial
          Tooltip(
            message: 'Editar saldo inicial',
            child: IconButton(
              icon: const Icon(Icons.savings),
              style: IconButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withAlpha(26),
              ),
              onPressed: _showEditInitialBalanceDialog,
            ),
          ),
          // Botão para limpar todos os dados (apenas para desenvolvimento)
          IconButton(
            icon: const Icon(Icons.delete_forever),
            style: IconButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: _clearAllData,
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BalanceDisplay(
                      currentBalance: '€ ${_currentBalance.toStringAsFixed(2)}',
                      projectedBalance:
                          '€ ${_projectedBalance.toStringAsFixed(2)}',
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
                              ? ListView.builder(
                                itemCount: _filteredTransactions.length,
                                itemBuilder: (context, index) {
                                  final transaction =
                                      _filteredTransactions[index];
                                  final isExpense = transaction.quantia < 0;
                                  final amount =
                                      isExpense
                                          ? '-€ ${(-transaction.quantia).toStringAsFixed(2)}'
                                          : '+€ ${transaction.quantia.toStringAsFixed(2)}';
                                  final date =
                                      '${transaction.data.day}/${transaction.data.month}/${transaction.data.year}';

                                  return TransactionListItem(
                                    title: transaction.titulo,
                                    amount: amount,
                                    date: date,
                                    onEditTap:
                                        () => _editTransaction(transaction),
                                    onDeleteTap:
                                        () =>
                                            _deleteTransaction(transaction.id),
                                  );
                                },
                              )
                              : EmptyStateWidget(
                                icon: Icons.receipt_long,
                                message: 'Nenhuma transação encontrada',
                                subMessage:
                                    _searchQuery.isNotEmpty
                                        ? 'Tente usar outros termos de pesquisa'
                                        : 'Adicione sua primeira transação usando o botão abaixo',
                                actionLabel: 'Adicionar Transação',
                                onAction: _navigateToAddTransaction,
                              ),
                    ),
                  ],
                ),
              ),
      floatingActionButton:
          _hasTransactions
              ? FloatingActionButton(
                onPressed: _navigateToAddTransaction,
                tooltip: 'Adicionar Transação',
                child: const Icon(Icons.add_card),
              )
              : null, // Não mostrar o botão quando não há transações
    );
  }
}
