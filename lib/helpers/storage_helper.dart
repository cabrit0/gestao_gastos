import 'dart:async';
import '../models/transacao.dart';

/// Classe utilitária para gerenciar o armazenamento persistente de dados.
///
/// Fornece métodos para carregar e salvar transações e o saldo total.
/// Nesta fase, implementa apenas assinaturas e comportamentos simulados.
/// A implementação real será feita na Fase 5.
class StorageHelper {
  // Chaves para armazenamento (serão utilizadas na Fase 5)
  // static const String _transactionsKey = 'transactions';
  // static const String _totalBalanceKey = 'total_balance';

  /// Carrega a lista de transações do armazenamento.
  ///
  /// Retorna uma lista vazia por enquanto.
  /// Na Fase 5, implementaremos a lógica real para carregar do SharedPreferences.
  static Future<List<Transacao>> loadTransactions() async {
    // Simulação de delay de rede/IO
    print('StorageHelper: loadTransactions (placeholder)');
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Retorna lista vazia por enquanto
    return [];
  }

  /// Salva a lista de transações no armazenamento.
  ///
  /// Apenas simula o salvamento por enquanto.
  /// Na Fase 5, implementaremos a lógica real para salvar no SharedPreferences.
  static Future<void> saveTransactions(List<Transacao> transactions) async {
    // Simulação de delay de rede/IO
    print('StorageHelper: saveTransactions (placeholder) - ${transactions.length} items');
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Não faz nada por enquanto
  }

  /// Carrega o saldo total do armazenamento.
  ///
  /// Retorna 0.0 por enquanto.
  /// Na Fase 5, implementaremos a lógica real para carregar do SharedPreferences.
  static Future<double> loadTotalBalance() async {
    // Simulação de delay de rede/IO
    print('StorageHelper: loadTotalBalance (placeholder)');
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Retorna 0.0 por enquanto
    return 0.0;
  }

  /// Salva o saldo total no armazenamento.
  ///
  /// Apenas simula o salvamento por enquanto.
  /// Na Fase 5, implementaremos a lógica real para salvar no SharedPreferences.
  static Future<void> saveTotalBalance(double balance) async {
    // Simulação de delay de rede/IO
    print('StorageHelper: saveTotalBalance (placeholder) - $balance');
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Não faz nada por enquanto
  }
}
