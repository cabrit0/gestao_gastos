import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transacao.dart';

// Classe para gerenciar o armazenamento de dados
class StorageHelper {
  // Chaves para armazenamento
  static const String _transactionsKey = 'transactions';
  static const String _initialBalanceKey = 'initial_balance';
  static const String _totalBalanceKey =
      'total_balance'; // Chave antiga, mantida para compatibilidade

  // Carrega a lista de transações do SharedPreferences
  static Future<List<Transacao>> loadTransactions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_transactionsKey);

      if (jsonString == null) {
        return [];
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      // Converte cada JSON para um objeto Transacao
      return jsonList.map((json) => Transacao.fromJson(json)).toList();
    } catch (e) {
      print('Erro ao carregar transações: $e');
      return [];
    }
  }

  // Salva a lista de transações no SharedPreferences
  static Future<void> saveTransactions(List<Transacao> transactions) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Converte cada Transacao para JSON
      final jsonList = transactions.map((tx) => tx.toJson()).toList();
      // Codifica a lista de JSONs
      final jsonString = jsonEncode(jsonList);

      await prefs.setString(_transactionsKey, jsonString);
    } catch (e) {
      print('Erro ao salvar transações: $e');
    }
  }

  // Carrega o saldo inicial do SharedPreferences
  static Future<double> loadInitialBalance() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Verificar primeiro a nova chave, depois a antiga para compatibilidade
      double? balance = prefs.getDouble(_initialBalanceKey);
      if (balance == null) {
        // Se não encontrar na nova chave, tentar na antiga
        balance = prefs.getDouble(_totalBalanceKey);
        // Se encontrar na antiga, migrar para a nova
        if (balance != null) {
          await prefs.setDouble(_initialBalanceKey, balance);
          await prefs.remove(_totalBalanceKey); // Remover a chave antiga
        }
      }
      return balance ?? 0.0;
    } catch (e) {
      print('Erro ao carregar saldo inicial: $e');
      return 0.0;
    }
  }

  // Salva o saldo inicial no SharedPreferences
  static Future<void> saveInitialBalance(double balance) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_initialBalanceKey, balance);
    } catch (e) {
      print('Erro ao salvar saldo inicial: $e');
    }
  }

  /// Limpa todos os dados armazenados
  static Future<void> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      print('Todos os dados foram limpos com sucesso');
    } catch (e) {
      print('Erro ao limpar dados: $e');
    }
  }
}
