# Tarefas Detalhadas (Foco Visual Primeiro): Gestor de Gastos

Acompanhe o progresso marcando as caixas de seleção (`- [x]`) à medida que cada subtarefa é concluída. Esta abordagem prioriza a criação da estrutura visual e da navegação antes de implementar a lógica completa de dados, conforme planeado.

**Fase 1: Configuração do Projeto e Tema Base**

- [x] **1.1 Criar Projeto Flutter:**
  - [x] E ecutar `flutter create gestor_gastos`.
  - [x] Navegar para a diretoria do projeto (`cd gestor_gastos`).
- [x] **1.2 Adicionar Dependências Iniciais:**
  - [x] Abrir `pubspec.yaml`.
  - [x] Adicionar `shared_preferences: ^2.0.6` (Versão **exata** do enunciado).
  - [ ] (Opcional, para Fase 6) Adicionar `intl: ^0.18.0` (ou mais recente estável). Comentar se não for usar já.
  - [x] Salvar `pubspec.yaml`.
  - [x] Executar `flutter pub get` no terminal.
- [x] **1.3 Definir Tema Central:**

  - [x] Criar a pasta `lib/theme`.
  - [x] Criar o ficheiro `lib/theme/app_theme.dart`.
  - [x] Dentro de `app_theme.dart`, definir uma classe `AppTheme` com um método estático `get lightTheme` que retorna um `ThemeData`. Ex:

    ```dart
    import 'package:flutter/material.dart';

    class AppTheme {
      static ThemeData get lightTheme {
        return ThemeData(
          primarySwatch: Colors.indigo, // Cor primária exemplo
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // Outras personalizações: appBarTheme, textTheme, colorScheme, inputDecorationTheme etc.
          appBarTheme: const AppBarTheme(
            elevation: 1, // Exemplo
            centerTitle: true,
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
            brightness: Brightness.light,
          ).copyWith(secondary: Colors.amber), // Accent color
        );
      }
      // Poderia adicionar darkTheme aqui também se desejado no futuro
    }
    ```

- [x] **1.4 Configurar `main.dart` com Tema e Rota Inicial:**
  - [x] Abrir `lib/main.dart`.
  - [x] Limpar o código de exemplo (Counter App).
  - [x] Importar `package:flutter/material.dart`, `lib/theme/app_theme.dart`, e `lib/screens/main_screen.dart` (será criado a seguir).
  - [x] Implementar `MyApp` como `StatelessWidget`.
  - [x] No `build` de `MyApp`, retornar `MaterialApp`.
  - [x] Definir `title: 'Gestor de Gastos'`.
  - [x] Aplicar o tema: `theme: AppTheme.lightTheme`.
  - [x] Definir a rota inicial: `home: const MainScreen()`. _(Nota: Rotas nomeadas seriam mais escaláveis, mas `home` é suficiente aqui)._
  - [x] Garantir que `runApp(const MyApp());` está na função `main()`.

**Fase 2: Layout Básico dos Ecrãs (Sem Lógica de Dados)**

- [x] **2.1 Criar Estrutura de Pastas para Ecrãs e Widgets:**
  - [x] Criar a pasta `lib/screens` (se não existir).
  - [x] Criar a pasta `lib/widgets` (se não existir).
- [x] **2.2 Layout Básico - `MainScreen`:**
  - [x] Criar `lib/screens/main_screen.dart`.
  - [x] Implementar `MainScreen` como `StatelessWidget` _nesta fase_.
  - [x] Importar `package:flutter/material.dart`.
  - [x] No método `build`, retornar um `Scaffold`.
  - [x] Adicionar `AppBar` com `title: const Text('Gestor de Gastos')`.
    - [x] Adicionar um `IconButton` na `actions` da `AppBar` (ícone `Icons.account_balance_wallet`) com `onPressed: () {}` (para futuro diálogo de editar saldo).
  - [x] No `body` do `Scaffold`, adicionar `Padding` envolvendo uma `Column`.
  - [x] Dentro da `Column`:
    - [x] **Placeholder para Saldos:** Adicionar `Padding` contendo `Column` com `Text` widgets (e.g., "Saldo Total: € --.--", "Saldo Disponível: € --.--"). Usar `Theme.of(context).textTheme` para estilo.
    - [x] **Placeholder para Filtro:** Adicionar `Padding` com um `TextField` básico (sem `controller` ainda, apenas `decoration: InputDecoration(labelText: 'Filtrar...')`).
    - [x] **Placeholder para Lista:** Adicionar `Expanded` contendo um `ListView` com alguns `ListTile`s hardcoded (e.g., `ListTile(title: Text('Compra X'), subtitle: Text('10/10/2024'), trailing: Text('-€15.00'))`) ou um `Center(child: Text("Nenhuma transação."))`.
  - [x] Adicionar `FloatingActionButton` com `icon: const Icon(Icons.add)` e um `onPressed: () {}` vazio por agora.
- [x] **2.3 Layout Básico - `TransactionScreen`:**
  - [x] Criar `lib/screens/transaction_screen.dart`.
  - [x] Implementar `TransactionScreen` como `StatelessWidget` _nesta fase_.
  - [x] Adicionar construtor `const TransactionScreen({super.key, required this.isEditing});` e `final bool isEditing;`.
  - [x] Importar `package:flutter/material.dart`.
  - [x] No método `build`, retornar um `Scaffold`.
  - [x] Adicionar `AppBar` com `title: Text(isEditing ? 'Editar Transação' : 'Adicionar Transação')`.
  - [x] No `body` do `Scaffold`, adicionar `SingleChildScrollView` (para evitar overflow) contendo `Padding` com um `Column`. _(Poderia ser `Form` já, mas sem `key`/validação ainda)._
  - [x] Dentro da `Column`:
    - [x] `TextFormField` para Título (sem `controller`, com `decoration: InputDecoration(labelText: 'Título')`).
    - [x] `TextFormField` para Quantia (sem `controller`, com `decoration: InputDecoration(labelText: 'Quantia', prefixText: '€ '), keyboardType: TextInputType.numberWithOptions(decimal: true)`).
    - [x] `Row` contendo:
      - [x] `Expanded(child: Text("Data: -- / -- / ----"))` (Placeholder da data selecionada).
      - [x] `TextButton` com `child: const Text("Selecionar Data")` e `onPressed: () {}`.
    - [x] `SizedBox(height: 20)` para espaçamento.
    - [x] `ElevatedButton` com `child: const Text("Guardar")` e `onPressed: () {}`. Esticar o botão (`SizedBox(width: double.infinity, ...)` ou `Row/MainAxisAlignment.center`).
- [x] **2.4 Configurar Navegação Básica (Placeholder):**
  - [x] Em `main_screen.dart`, no `onPressed` do `FloatingActionButton`:
    ```dart
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TransactionScreen(isEditing: false), // Sempre adicionar por agora
      ),
    );
    ```
  - [x] Em `transaction_screen.dart`, no `onPressed` do botão "Guardar":
    ```dart
    Navigator.pop(context); // Apenas fecha o ecrã, sem passar dados
    ```
- [x] **2.5 Verificação Visual e Navegação:**
  - [x] Executar a aplicação (`flutter run`).
  - [x] Verificar se o `MainScreen` aparece com o tema, AppBar, placeholders de saldo, filtro, lista e FAB.
  - [x] Clicar no FAB deve abrir o `TransactionScreen`.
  - [x] Verificar se o título da `AppBar` no `TransactionScreen` é "Adicionar Transação".
  - [x] Verificar se os campos do formulário e botões estão visíveis.
  - [x] Clicar em "Selecionar Data" não faz nada (ok por agora).
  - [x] Clicar em "Guardar" deve fechar o `TransactionScreen` e voltar para o `MainScreen`.

**Fase 3: Widgets Reutilizáveis Básicos (Ainda com Dados Falsos)** ✓

- [x] **3.1 Widget Básico - `TransactionListItem`:**
  - [x] Criar `lib/widgets/transaction_list_item.dart`.
  - [x] Implementar `TransactionListItem` como `StatelessWidget`.
  - [x] Adicionar construtor: `const TransactionListItem({ super.key, required this.title, required this.amount, required this.date, required this.onEditTap, required this.onDeleteTap });`. Campos `final`.
  - [x] Adicionar parâmetros: `final String title`, `final String amount` (String formatada por agora), `final String date` (String formatada), `final VoidCallback onEditTap`, `final VoidCallback onDeleteTap`.
  - [x] No `build`, retornar um `Card` envolvendo um `ListTile`.
  - [x] Configurar `ListTile`:
    - [x] `title: Text(title)`.
    - [x] `subtitle: Text(date)`.
    - [x] `leading: CircleAvatar(child: Icon(Icons.attach_money))` (Exemplo).
    - [x] `trailing: Row(mainAxisSize: MainAxisSize.min, children: [ Text(amount), IconButton(icon: Icon(Icons.edit), onPressed: onEditTap), IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: onDeleteTap) ])`. Ajustar layout/estilo conforme necessário.
- [x] **3.2 (Opcional, mas Recomendado) Widget Básico - `BalanceDisplay`:**
  - [x] Criar `lib/widgets/balance_display.dart`.
  - [x] Implementar como `StatelessWidget`.
  - [x] Adicionar construtor: `const BalanceDisplay({ super.key, required this.totalBalance, required this.availableBalance });`. Campos `final`.
  - [x] Adicionar parâmetros: `final String totalBalance`, `final String availableBalance` (Strings formatadas).
  - [x] No `build`, retornar um `Card` ou `Padding` contendo uma `Column` (ou `Row`) com dois `Text` widgets para exibir os saldos com `Labels` (e.g., "Saldo Total:", "Disponível:"). Aplicar estilos do tema.
- [x] **3.3 Integrar Widgets Básicos no `MainScreen`:**

  - [x] Em `main_screen.dart`, importar os novos widgets (`transaction_list_item.dart`, `balance_display.dart` se criado).
  - [x] Substituir o placeholder de saldos pelo `BalanceDisplay` (passando strings hardcoded como `"€ 1000.00"`, `"€ 500.50"`).
  - [x] No `ListView`, substituir os `ListTile`s hardcoded por alguns `TransactionListItem`s. Passar dados hardcoded e `onPressed: () {}` vazios para `onEditTap` e `onDeleteTap`. Ex:
    ```dart
    TransactionListItem(
      title: 'Supermercado',
      amount: '-€ 45.60',
      date: '15/10/2024',
      onEditTap: () { print('Edit tapped'); },
      onDeleteTap: () { print('Delete tapped'); },
    ),
    ```
  - [x] Executar e verificar a aparência visual atualizada do `MainScreen`.

- [x] **3.4 Widget Adicional - `DateSelector`:**

  - [x] Criar `lib/widgets/date_selector.dart`.
  - [x] Implementar como `StatelessWidget`.
  - [x] Adicionar construtor com parâmetros: `selectedDate`, `onDateSelected` e `labelText`.
  - [x] Implementar seletor de data com `showDatePicker` e formatação consistente.
  - [x] Integrar o widget no `TransactionScreen`.

- [x] **3.5 Widget Adicional - `AmountInput`:**

  - [x] Criar `lib/widgets/amount_input.dart`.
  - [x] Implementar como `StatelessWidget`.
  - [x] Adicionar construtor com parâmetros: `controller`, `labelText`, `currencySymbol`, `onChanged` e `validator`.
  - [x] Implementar formatação e validação para valores monetários.
  - [x] Integrar o widget no `TransactionScreen`.

- [x] **3.6 Widget Adicional - `ConfirmationDialog`:**
  - [x] Criar `lib/widgets/confirmation_dialog.dart`.
  - [x] Implementar como classe utilitária com método estático `show`.
  - [x] Adicionar parâmetros: `title`, `content`, `confirmLabel`, `cancelLabel`, `isDestructive` e `onConfirm`.
  - [x] Implementar diálogo de confirmação com opções de confirmar e cancelar.
  - [x] Integrar o widget no `MainScreen` para confirmação de exclusão de transações.

**Fase 4: Modelo de Dados e Interface do Storage (Sem Implementação Completa)**

- [ ] **4.1 Definir Modelo `Transacao`:**

  - [ ] Criar a pasta `lib/models` (se não existir).
  - [ ] Criar `lib/models/transacao.dart`.
  - [ ] Implementar a classe `Transacao` exatamente como no enunciado/`PLANNING.md`:

    ```dart
    class Transacao {
      final String id;
      final String titulo;
      final double quantia;
      final DateTime data;

      Transacao({
        required this.id,
        required this.titulo,
        required this.quantia,
        required this.data,
      });

      // toJson e fromJson serão adicionados na Fase 5
    }
    ```

- [ ] **4.2 Definir Interface do `StorageHelper` (Assinaturas):**

  - [ ] Criar pasta `lib/helpers` (se não existir).
  - [ ] Criar `lib/helpers/storage_helper.dart`.
  - [ ] Adicionar import `../models/transacao.dart`.
  - [ ] Definir a classe `StorageHelper`.
  - [ ] Definir as **assinaturas exatas** dos métodos estáticos, mas com implementações vazias/padrão para que o código compile e a interface esteja definida:

    ```dart
    import '../models/transacao.dart';
    // Adicionar outros imports necessários (dart:async)

    class StorageHelper {
      // Chaves serão definidas na Fase 5
      // static const String _transactionsKey = 'transactions';
      // static const String _totalBalanceKey = 'total_balance';

      static Future<List<Transacao>> loadTransactions() async {
        // Lógica será implementada na Fase 5
        print('StorageHelper: loadTransactions (placeholder)'); // Log
        await Future.delayed(const Duration(milliseconds: 100)); // Simular delay
        return []; // Retorna vazio por agora
      }

      static Future<void> saveTransactions(List<Transacao> transactions) async {
        // Lógica será implementada na Fase 5
         print('StorageHelper: saveTransactions (placeholder) - ${transactions.length} items');
        await Future.delayed(const Duration(milliseconds: 50)); // Simular delay
      }

      static Future<double> loadTotalBalance() async {
        // Lógica será implementada na Fase 5
        print('StorageHelper: loadTotalBalance (placeholder)');
        await Future.delayed(const Duration(milliseconds: 50));
        return 0.0; // Retorna 0.0 por agora
      }

      static Future<void> saveTotalBalance(double balance) async {
        // Lógica será implementada na Fase 5
        print('StorageHelper: saveTotalBalance (placeholder) - $balance');
         await Future.delayed(const Duration(milliseconds: 50));
      }
    }
    ```

**Fase 5: Implementar Lógica de Dados e Estado**

- [ ] **5.1 Implementar `toJson`/`fromJson` no Modelo `Transacao`:**
  - [ ] Abrir `lib/models/transacao.dart`.
  - [ ] **Não** adicionar import `dart:convert` aqui (será usado no `StorageHelper`).
  - [ ] Implementar o método `Map<String, dynamic> toJson()`: Deve converter `DateTime` para String (e.g., ISO 8601 `data.toIso8601String()`).
  - [ ] Implementar o factory constructor `Transacao.fromJson(Map<String, dynamic> json)`: Deve converter a String da data de volta para `DateTime` (e.g., `DateTime.parse(json['data'])`) e `json['quantia']` para `double`.
- [ ] **5.2 Implementar Lógica REAL do `StorageHelper`:**
  - [ ] Abrir `lib/helpers/storage_helper.dart`.
  - [ ] Adicionar imports: `dart:convert`, `package:shared_preferences/shared_preferences.dart`.
  - [ ] Definir as constantes estáticas para as chaves (e.g., `_transactionsKey`, `_totalBalanceKey`).
  - [ ] Implementar a lógica **real** dentro dos 4 métodos estáticos usando `SharedPreferences.getInstance()`, `getString`, `setString`, `getDouble`, `setDouble`.
  - [ ] Em `saveTransactions`: Usar `jsonEncode` após mapear a lista de `Transacao` para `List<Map>`.
  - [ ] Em `loadTransactions`: Usar `jsonDecode`, verificar se o resultado não é nulo, e mapear a `List<dynamic>` para `List<Transacao>` usando `Transacao.fromJson`.
  - [ ] Adicionar `try-catch` robustos em volta das operações de `shared_preferences` e `jsonDecode`/`fromJson` para lidar com possíveis erros (e.g., dados corrompidos, tipo errado). Retornar valores padrão (lista vazia, 0.0) em caso de erro. Usar `print` para logar erros.
- [ ] **5.3 Converter Ecrãs para `StatefulWidget` e Adicionar Estado:**
  - [ ] Modificar `MainScreen` para ser um `StatefulWidget`.
    - [ ] Criar `_MainScreenState extends State<MainScreen>`.
    - [ ] Mover o método `build` para `_MainScreenState`.
    - [ ] Adicionar variáveis de estado em `_MainScreenState`: `List<Transacao> _allTransactions = [];`, `List<Transacao> _filteredTransactions = [];`, `double _totalBalance = 0.0;`, `double _availableBalance = 0.0;`, `final TextEditingController _filterController = TextEditingController();`, `bool _isLoading = true;`.
  - [ ] Modificar `TransactionScreen` para ser um `StatefulWidget`.
    - [ ] Adicionar construtor que aceita `final Transacao? existingTransaction;`.
    - [ ] Criar `_TransactionScreenState extends State<TransactionScreen>`.
    - [ ] Mover o `build` para `_TransactionScreenState`.
    - [ ] Remover o parâmetro `isEditing` do construtor do Widget (será gerido no State).
    - [ ] Adicionar variáveis de estado em `_TransactionScreenState`: `final _formKey = GlobalKey<FormState>();`, `final _titleController = TextEditingController();`, `final _amountController = TextEditingController();`, `DateTime? _selectedDate;`, `bool _isEditing = false;`.
- [ ] **5.4 Carregar Dados no `MainScreen`:**
  - [ ] Em `_MainScreenState`:
    - [ ] Implementar `initState()`:
      - `super.initState();`
      - Inicializar `_filterController`.
      - Adicionar listener ao `_filterController` para chamar `_filterTransactions()`.
      - Chamar uma nova função `_loadData()`.
    - [ ] Implementar `dispose()`:
      - Descartar `_filterController`.
      - `super.dispose();`
    - [ ] Implementar `Future<void> _loadData()`:
      - `if (!mounted) return; setState(() { _isLoading = true; });`
      - Carregar dados: `_totalBalance = await StorageHelper.loadTotalBalance();`, `_allTransactions = await StorageHelper.loadTransactions();`.
      - Calcular `_availableBalance`: `_totalBalance - _allTransactions.fold(0.0, (sum, item) => sum + item.quantia);`
      - Inicializar `_filteredTransactions = _allTransactions;` (ou aplicar filtro existente).
      - Chamar `_filterTransactions()` para aplicar o filtro inicial se houver texto no controller.
      - `if (!mounted) return; setState(() { _isLoading = false; });`
  - [ ] No método `build` de `_MainScreenState`:
    - [ ] Usar `_isLoading` para mostrar um `CircularProgressIndicator` centrado se for `true`, caso contrário mostrar o `Column` principal.
    - [ ] Passar valores reais (`_totalBalance`, `_availableBalance` formatados) para `BalanceDisplay`. (Usar `intl` aqui se adicionado).
    - [ ] Ligar `_filterController` ao `TextField` de filtro.
    - [ ] Usar `_filteredTransactions` no `ListView.builder`.
    - [ ] Configurar `itemCount` e `itemBuilder` do `ListView.builder`.
    - [ ] No `itemBuilder`, criar `TransactionListItem` passando dados da `_filteredTransactions[index]` e ligando `onEditTap` e `onDeleteTap` a novas funções (`_editTransaction`, `_deleteTransaction`). (Formatar dados aqui se usar `intl`).
- [ ] **5.5 Implementar Lógica do Formulário (`TransactionScreen`):**
  - [ ] Em `_TransactionScreenState`:
    - [ ] Implementar `initState()`:
      - `super.initState();`
      - Verificar se `widget.existingTransaction != null`. Se sim:
        - Definir `_isEditing = true`.
        - Preencher `_titleController.text`, `_amountController.text` (formatado), e `_selectedDate` com os dados de `widget.existingTransaction`.
      - Se não, inicializar `_selectedDate = DateTime.now();`.
    - [ ] Implementar `dispose()`: Descartar `_titleController`, `_amountController`.
    - [ ] Implementar `Future<void> _presentDatePicker()`:
      - Chamar `showDatePicker`, obter a data selecionada.
      - Se uma data for selecionada, `setState(() { _selectedDate = pickedDate; });`.
    - [ ] Ligar `_presentDatePicker` ao `onPressed` do botão "Selecionar Data".
    - [ ] Exibir a `_selectedDate` formatada no `Text` ao lado do botão (usar `intl` se disponível).
    - [ ] Ligar `_titleController` e `_amountController` aos respetivos `TextFormField`s.
    - [ ] Ligar `_formKey` ao `Form` widget que deve envolver os campos.
    - [ ] Adicionar `validator` aos `TextFormField`s:
      - Título: Verificar se não está vazio (`value?.isEmpty ?? true`).
      - Quantia: Verificar se não está vazio, se `double.tryParse` não retorna `null`, e se o valor é > 0.
    - [ ] Implementar `Future<void> _submitData()`:
      - Validar o formulário: `if (!(_formKey.currentState?.validate() ?? false)) { return; }`
      - Se validado, ler valores dos controllers. Usar `double.tryParse(_amountController.text)` para a quantia. Verificar se `_selectedDate` não é nulo.
      - Mostrar indicador de progresso (opcional).
      - Carregar transações existentes: `List<Transacao> transactions = await StorageHelper.loadTransactions();`
      - Se `_isEditing`:
        - Encontrar a transação existente na lista pelo ID.
        - Criar uma nova `Transacao` com os dados atualizados (mantendo o ID).
        - Substituir a antiga pela nova na lista.
      - Se não `_isEditing`:
        - Criar uma nova `Transacao` (gerar novo ID único: `DateTime.now().millisecondsSinceEpoch.toString()`).
        - Adicionar a nova transação à lista.
      - Salvar a lista atualizada: `await StorageHelper.saveTransactions(transactions);`
      - Se `mounted`, chamar `Navigator.pop(context, true);` (passar `true` para indicar sucesso/alteração).
      - Esconder indicador de progresso (opcional).
      - Adicionar tratamento de erro básico (`try-catch`) em volta da lógica de salvar/carregar.
    - [ ] Ligar `_submitData` ao `onPressed` do botão "Guardar".
- [ ] **5.6 Implementar Funcionalidades Restantes no `MainScreen`:**
  - [ ] **Lógica de Filtragem:**
    - [ ] Implementar `void _filterTransactions()`:
      - Obter o texto do filtro: `final query = _filterController.text.toLowerCase();`.
      - Filtrar `_allTransactions`: `final filtered = _allTransactions.where((tx) => tx.titulo.toLowerCase().contains(query)).toList();`
      - `setState(() { _filteredTransactions = filtered; });`
      - (Opcional: filtrar também por data ou quantia se desejado).
  - [ ] **Navegação para Adicionar/Editar:**
    - [ ] Modificar `onPressed` do FAB para chamar uma função `_navigateToAddTransaction()`.
    - [ ] Implementar `void _navigateToAddTransaction()`:
      - `final result = await Navigator.push(...)` (Navega para `TransactionScreen(existingTransaction: null)`).
      - `if (result == true && mounted) { _loadData(); }` // Recarrega se algo foi salvo.
    - [ ] Implementar `void _editTransaction(Transacao transaction)`:
      - `final result = await Navigator.push(...)` (Navega para `TransactionScreen(existingTransaction: transaction)`).
      - `if (result == true && mounted) { _loadData(); }` // Recarrega se algo foi salvo.
    - [ ] Passar `_editTransaction` para o `onEditTap` do `TransactionListItem` no `itemBuilder`.
  - [ ] **Lógica de Remoção:**
    - [ ] Implementar `Future<void> _deleteTransaction(String id)`:
      - Mostrar um `AlertDialog` de confirmação (`showDialog`).
      - Se o utilizador confirmar:
        - Carregar transações: `List<Transacao> transactions = await StorageHelper.loadTransactions();`
        - Remover a transação com o `id` correspondente: `transactions.removeWhere((tx) => tx.id == id);`
        - Salvar a lista atualizada: `await StorageHelper.saveTransactions(transactions);`
        - Se `mounted`, chamar `_loadData()` para atualizar a UI.
      - Adicionar `try-catch`.
    - [ ] Passar `_deleteTransaction` para o `onDeleteTap` do `TransactionListItem` no `itemBuilder`, passando o `id` da transação.
  - [ ] **Lógica de Editar Saldo Total:**
    - [ ] Implementar `Future<void> _showEditTotalBalanceDialog()`:
      - Criar um `TextEditingController` para o diálogo.
      - Mostrar um `AlertDialog` com um `TextField` (numérico) para o novo saldo.
      - No botão "Guardar" do diálogo:
        - Fazer `double.tryParse` do valor do controller.
        - Se válido, chamar `await StorageHelper.saveTotalBalance(newBalance);`.
        - Fechar o diálogo (`Navigator.pop(context)`).
        - Se `mounted`, chamar `_loadData()` para atualizar.
      - Ligar `_showEditTotalBalanceDialog` ao `onPressed` do `IconButton` na `AppBar`.

**Fase 6: Refinamento e Testes**

- [ ] **6.1 Adicionar Formatação (`intl`):**
  - [ ] Se `intl` foi adicionado, importar `package:intl/intl.dart` onde necessário (`main_screen.dart`, `transaction_screen.dart`, `transaction_list_item.dart`).
  - [ ] Inicializar `intl` (se necessário, para locales específicos, embora para formatos padrão muitas vezes não precise de inicialização explícita).
  - [ ] Formatar datas: Usar `DateFormat('dd/MM/yyyy').format(dateTimeObject)` (ou outro formato).
  - [ ] Formatar quantias: Usar `NumberFormat.currency(locale: 'pt_PT', symbol: '€').format(doubleValue)`.
  - [ ] Aplicar formatação nos locais onde datas e quantias são exibidas (`TransactionListItem`, `BalanceDisplay`, `TransactionScreen`).
- [ ] **6.2 Testes Funcionais Completos:**
  - [ ] Executar a aplicação em emulador/dispositivo.
  - [ ] Testar Adicionar transação (com validação).
  - [ ] Testar Editar transação (verificar preenchimento e salvamento).
  - [ ] Testar Remover transação (com confirmação).
  - [ ] Testar Filtrar transações (por título).
  - [ ] Testar Editar Saldo Total.
  - [ ] Testar persistência: Fechar e reabrir a app, verificar se os dados (transações, saldo total) são carregados corretamente.
  - [ ] Testar casos limite: Nenhuma transação, filtro que não encontra nada, valores inválidos no formulário.
  - [ ] Verificar se o Saldo Disponível é calculado e atualizado corretamente após cada operação.
- [ ] **6.3 Revisão de Código e Usabilidade:**
  - [ ] Rever o código: Clareza, organização, comentários onde necessário, remoção de código morto ou `print`s de debug desnecessários.
  - [ ] Executar `dart format .` e `flutter analyze` para garantir conformidade.
  - [ ] Avaliar a UI/UX: A navegação é intuitiva? A informação está clara? Os botões são fáceis de usar? Há feedback visual suficiente (e.g., `isLoading`)?
