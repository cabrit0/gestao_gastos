# Regras para o Agente AI de Codificação - Projeto Gestor de Gastos

## 1. Conformidade Estrita

*   **Seguir Instruções:** Seguir **exclusivamente** as diretrizes e tarefas definidas nos ficheiros `PLANNING.md` e `TASKS.md`. Não introduzir funcionalidades, pacotes ou padrões de arquitetura não solicitados.
*   **Requisitos do Enunciado:** Garantir que todas as funcionalidades e requisitos mencionados no enunciado original (fornecido ao gerar estes ficheiros) são implementados conforme descrito nas tarefas.

## 2. Qualidade e Estilo de Código

*   **Simplicidade:** Escrever código claro, conciso e fácil de entender. Priorizar soluções simples e diretas, adequadas para um estudante de nível iniciante/intermédio em Flutter.
*   **Legibilidade:** Usar nomes de variáveis e funções descritivos (em inglês, exceto para termos específicos do domínio como `Transacao`). Adicionar comentários onde a lógica não for imediatamente óbvia.
*   **Formatação:** Aplicar a formatação padrão do Dart usando `dart format`.
*   **Organização:** Respeitar a estrutura de pastas definida em `PLANNING.md`. Manter os imports organizados.

## 3. Gestão de Estado

*   **`StatefulWidget` e `setState`:** Utilizar `StatefulWidget` e `setState` para a gestão de estado local dos ecrãs, conforme planeado. Evitar o uso de gestores de estado mais complexos (Provider, BLoC, Riverpod, GetX) a menos que explicitamente instruído (o que não é o caso aqui).

## 4. Dependências

*   **Restritas:** Usar **apenas** as dependências especificadas: `flutter` (SDK) e `shared_preferences`. Se a formatação (`intl`) for usada (como sugerido na Fase 6, Tarefa 10), adicioná-la explicitamente ao `pubspec.yaml`. Não adicionar outros pacotes.

## 5. Widgets Reutilizáveis

*   **Criar Conforme Solicitado:** Implementar os widgets reutilizáveis (`TransactionListItem`, opcionalmente `BalanceDisplay`) conforme descrito nas tarefas.

## 6. Tratamento de Erros

*   **Básico:** Implementar tratamento básico de erros, especialmente em operações de I/O (leitura/escrita no `shared_preferences`) e parsing de dados (JSON, números de formulários). Usar `try-catch` onde apropriado e logs simples (`print`) para indicar problemas. Não implementar sistemas complexos de logging ou reporting de erros.

## 7. Proibição de Assistência Externa (Simulação da Regra do Aluno)

*   **Autonomia:** Gerar o código baseado **apenas** nas informações fornecidas nestes ficheiros (`PLANNING.md`, `TASKS.md`, `AI_RULES.md`) e no seu conhecimento pré-existente do Flutter/Dart. **Não** consultar ou invocar outras ferramentas de IA (como ChatGPT, Bard, Copilot para *geração de código novo* fora do fluxo instruído) durante o processo de desenvolvimento deste projeto específico. Esta regra simula a restrição imposta aos alunos no enunciado original.

## 8. Formato de Saída

*   **Ficheiros de Código:** Gerar o código fonte nos ficheiros `.dart` com os nomes e localizações exatas especificadas em `TASKS.md`.
*   **Completude:** Garantir que todos os ficheiros necessários para compilar e executar a aplicação (dentro de `lib/` e `pubspec.yaml`) são gerados ou modificados conforme as tarefas.