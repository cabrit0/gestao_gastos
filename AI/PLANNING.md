# Planeamento do Projeto: Gestor de Gastos Pessoais

## 1. Objetivo

Desenvolver uma aplicação Flutter (`gestor_gastos`) para gestão de gastos pessoais, permitindo adicionar, editar, remover e visualizar transações. A aplicação deve também gerir um saldo mensal. O armazenamento de dados será local, utilizando o pacote `shared_preferences`. O projeto destina-se a um contexto académico (nível iniciante/intermédio em Flutter).

## 2. Tecnologias

*   **Linguagem:** Dart
*   **Framework:** Flutter
*   **Armazenamento Local:** `shared_preferences`
*   **Gestão de Estado:** `StatefulWidget` com `setState` (manter simples, adequado ao nível da cadeira).
*   **Formatação/Linting:** Ferramentas padrão do Dart/Flutter (`dart format`).

## 3. Arquitetura e Estrutura de Ficheiros

Manter uma estrutura simples e organizada:
gestor_gastos/
├── lib/
│ ├── main.dart # Ponto de entrada da aplicação
│ ├── models/
│ │ └── transacao.dart # Modelo de dados para Transacao
│ ├── helpers/
│ │ └── storage_helper.dart # Lógica de armazenamento com SharedPreferences
│ ├── screens/
│ │ ├── main_screen.dart # Ecrã principal (lista, saldos, botões)
│ │ └── transaction_screen.dart # Ecrã para adicionar/editar transação
│ └── widgets/ # Widgets reutilizáveis
│ └── transaction_list_item.dart # Widget para um item da lista de transações
│ └── balance_display.dart # Widget para exibir saldos (opcional)
├── pubspec.yaml # Definição do projeto e dependências
└── ... # Outros ficheiros gerados pelo Flutter

## 4. Modelo de Dados (`Transacao`)

*   Localização: `lib/models/transacao.dart`
*   Propriedades:
    *   `id`: `String` (Identificador único, pode ser gerado com `DateTime.now().millisecondsSinceEpoch.toString()`)
    *   `titulo`: `String` (Descrição da transação)
    *   `quantia`: `double` (Valor da transação, positivo para rendimento, negativo para despesa - ou sempre positivo e usar um tipo extra, mas manteremos simples: assumir despesas)
    *   `data`: `DateTime` (Data da transação)
*   **Serialização:** O modelo precisará de métodos `toJson()` e `fromJson()` para facilitar a conversão de/para Map, que será usado antes de guardar/ler como String JSON no `shared_preferences`.

## 5. Armazenamento Local (`storage_helper.dart`)

*   Utilizar `shared_preferences`.
*   **Chaves:**
    *   `'transactions'`: Armazenará a lista de transações (serializada como String JSON).
    *   `'total_balance'`: Armazenará o saldo total definido pelo utilizador (como `double`).
*   **Lógica:**
    *   Carregar transações: Ler a String JSON da chave `'transactions'`, fazer `jsonDecode`, converter a `List<dynamic>` (de Maps) para `List<Transacao>` usando `Transacao.fromJson`. Retornar lista vazia se não existir ou ocorrer erro.
    *   Guardar transações: Converter `List<Transacao>` para `List<Map<String, dynamic>>` usando `toJson()`, fazer `jsonEncode` para obter uma String JSON, guardar na chave `'transactions'`.
    *   Carregar/Guardar saldo total: Usar `getDouble()` e `setDouble()` para a chave `'total_balance'`.

## 6. Interface do Utilizador (UI)

*   **`main_screen.dart`:**
    *   `StatefulWidget` para gerir a lista de transações e saldos.
    *   Exibir Saldo Total (lido/definido) e Saldo Disponível (calculado: Saldo Total - Soma das Transações). Widget `BalanceDisplay` opcional.
    *   `ListView.builder` para mostrar as transações usando `TransactionListItem`.
    *   `FloatingActionButton` para navegar para `TransactionScreen` (para adicionar).
    *   Opções em cada item da lista (e.g., `ListTile` com `trailing` icons) para Editar (navegar para `TransactionScreen` com dados) e Remover (com diálogo de confirmação).
    *   Campo de texto simples para filtrar a lista pelo `titulo`.
    *   Botão/Acção para modificar o Saldo Total (pode ser um simples `AlertDialog` com um `TextField`).
*   **`transaction_screen.dart`:**
    *   `StatefulWidget` para gerir o formulário.
    *   Receber `Transacao?` como argumento (null para adicionar, objeto para editar).
    *   `Form` com `TextFormField` para título e quantia, e um seletor de data (`showDatePicker`).
    *   Validação básica dos campos (obrigatório, numérico).
    *   Botão "Guardar" que:
        *   Valida o formulário.
        *   Cria/Atualiza o objeto `Transacao`.
        *   Chama `StorageHelper` para guardar a lista atualizada.
        *   Retorna à `MainScreen` (usando `Navigator.pop`).
*   **`transaction_list_item.dart`:**
    *   `StatelessWidget` que recebe uma `Transacao` e funções de callback para `onEdit` e `onDelete`.
    *   Exibe `titulo`, `quantia` (formatada como moeda), e `data` (formatada).
    *   Inclui botões/icons para editar e remover.

## 7. Funcionalidades Principais

1.  **Adicionar Transação:** Formulário -> Guardar no Storage -> Atualizar UI.
2.  **Editar Transação:** Item da Lista -> Navegar para Formulário com dados -> Guardar -> Atualizar UI.
3.  **Remover Transação:** Item da Lista -> Confirmação -> Remover do Storage -> Atualizar UI.
4.  **Visualizar Transações:** Carregar do Storage -> Exibir na Lista.
5.  **Filtrar Transações:** Campo de texto -> Atualizar lista exibida (sem alterar storage).
6.  **Gerir Saldo Total:** Botão/Acção -> Input do utilizador -> Guardar no Storage -> Atualizar UI.
7.  **Visualizar Saldos:** Ler Saldo Total do Storage, Calcular Saldo Disponível -> Exibir na UI.

## 8. Documentação de Referência

*   Flutter Docs: [https://docs.flutter.dev/](https://docs.flutter.dev/)
*   `shared_preferences`: [https://pub.dev/packages/shared_preferences](https://pub.dev/packages/shared_preferences)
*   JSON e Serialização em Dart/Flutter: [https://docs.flutter.dev/data-and-backend/serialization/json](https://docs.flutter.dev/data-and-backend/serialization/json)
*   Navegação: [https://docs.flutter.dev/ui/navigation](https://docs.flutter.dev/ui/navigation)
*   Formulários: [https://docs.flutter.dev/ui/forms](https://docs.flutter.dev/ui/forms)
*   State Management (StatefulWidget): [https://docs.flutter.dev/data-and-backend/state-mgmt/options#setstate](https://docs.flutter.dev/data-and-backend/state-mgmt/options#setstate)

