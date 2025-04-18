/// Modelo de dados para representar uma transação financeira.
///
/// Cada transação possui um identificador único, título, quantia e data.
/// A quantia pode ser positiva (receita) ou negativa (despesa).
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

  // Os métodos toJson e fromJson serão adicionados na Fase 5
}
