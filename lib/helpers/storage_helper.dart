import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transacao.dart';

// Classe para gerenciar o armazenamento de dados
class StorageHelper {
  // Chaves para armazenamento
  static const String _transactionsKey = 'transactions';
  static const String _totalBalanceKey = 'total_balance';

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

  // Carrega o saldo total do SharedPreferences
  static Future<double> loadTotalBalance() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(_totalBalanceKey) ?? 0.0;
    } catch (e) {
      print('Erro ao carregar saldo total: $e');
      return 0.0;
    }
  }

  // Salva o saldo total no SharedPreferences
  static Future<void> saveTotalBalance(double balance) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_totalBalanceKey, balance);
    } catch (e) {
      print('Erro ao salvar saldo total: $e');
    }
  }
}
