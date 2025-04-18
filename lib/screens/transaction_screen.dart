import 'package:flutter/material.dart';
import '../widgets/date_selector.dart';
import '../widgets/amount_input.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';
import '../models/transacao.dart';
import '../helpers/storage_helper.dart';

class TransactionScreen extends StatefulWidget {
  final Transacao? existingTransaction;

  const TransactionScreen({super.key, this.existingTransaction});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  // Form key para validação
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // Dados
  DateTime? _selectedDate;
  bool _isEditing = false;
  bool _isExpense = true; // Por padrão, é uma despesa

  @override
  void initState() {
    super.initState();

    // Verificar se estamos editando uma transação existente
    if (widget.existingTransaction != null) {
      _isEditing = true;
      _titleController.text = widget.existingTransaction!.titulo;

      // Determinar se é despesa ou ganho com base no valor
      final quantia = widget.existingTransaction!.quantia;
      _isExpense = quantia < 0;

      // Sempre mostrar o valor positivo no campo
      _amountController.text = quantia.abs().toString();
      _selectedDate = widget.existingTransaction!.data;
    } else {
      // Inicializar com a data atual para nova transação
      _selectedDate = DateTime.now();
      _isExpense = true; // Por padrão, é uma despesa
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // Valida e salva os dados do formulário
  Future<void> _submitData() async {
    // Validar o formulário
    if (!_formKey.currentState!.validate()) {
      return; // Retorna se o formulário não for válido
    }

    // Verificar se a data foi selecionada
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione uma data')),
      );
      return;
    }

    // Converter a quantia para double
    double? quantia = double.tryParse(_amountController.text);
    if (quantia == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Quantia inválida')));
      return;
    }

    // Se for uma despesa, tornar o valor negativo
    if (_isExpense) {
      quantia = -quantia.abs(); // Garantir que seja negativo
    } else {
      quantia = quantia.abs(); // Garantir que seja positivo
    }

    // Mostrar indicador de progresso
    setState(() {
      // Poderia adicionar um indicador de carregamento aqui
    });

    try {
      // Carregar transações existentes
      List<Transacao> transactions = await StorageHelper.loadTransactions();

      if (_isEditing && widget.existingTransaction != null) {
        // Encontrar a transação existente na lista
        final index = transactions.indexWhere(
          (tx) => tx.id == widget.existingTransaction!.id,
        );

        if (index >= 0) {
          // Criar uma nova transação com os dados atualizados (mantendo o ID)
          final updatedTransaction = Transacao(
            id: widget.existingTransaction!.id,
            titulo: _titleController.text,
            quantia: quantia,
            data: _selectedDate!,
          );

          // Substituir a antiga pela nova na lista
          transactions[index] = updatedTransaction;
        }
      } else {
        // Criar uma nova transação
        final newTransaction = Transacao(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          titulo: _titleController.text,
          quantia: quantia,
          data: _selectedDate!,
        );

        // Adicionar a nova transação à lista
        transactions.add(newTransaction);
      }

      // Salvar a lista atualizada
      await StorageHelper.saveTransactions(transactions);

      // Fechar a tela e retornar true para indicar sucesso
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      // Mostrar erro
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CustomAppBar(
        title: _isEditing ? 'Editar Transação' : 'Adicionar Transação',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um título';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Seletor de tipo de transação (Despesa/Ganho)
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<bool>(
                        title: const Text('Despesa'),
                        value: true,
                        groupValue: _isExpense,
                        onChanged: (value) {
                          setState(() {
                            _isExpense = value!;
                          });
                        },
                        activeColor: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<bool>(
                        title: const Text('Ganho'),
                        value: false,
                        groupValue: _isExpense,
                        onChanged: (value) {
                          setState(() {
                            _isExpense = value!;
                          });
                        },
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AmountInput(
                  controller: _amountController,
                  labelText: 'Quantia',
                  onChanged: (value) {
                    // Podemos adicionar lógica adicional aqui se necessário
                  },
                ),
                const SizedBox(height: 16),
                DateSelector(
                  selectedDate: _selectedDate,
                  onDateSelected: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  labelText: 'Data da Transação',
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitData,
                    child: const Text('Guardar'),
                  ),
                ),
                const SizedBox(height: 24),
                // Footer discreto
                const FooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
