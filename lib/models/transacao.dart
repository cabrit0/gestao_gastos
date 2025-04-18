/// Modelo de dados para representar uma transação financeira.
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

  // Converte a transação para um Map que pode ser armazenado como JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'quantia': quantia,
      'data': data.toIso8601String(),
    };
  }

  // Cria uma transação a partir de um Map (JSON)
  static Transacao fromJson(Map<String, dynamic> json) {
    return Transacao(
      id: json['id'],
      titulo: json['titulo'],
      quantia: json['quantia'],
      data: DateTime.parse(json['data']),
    );
  }
}
