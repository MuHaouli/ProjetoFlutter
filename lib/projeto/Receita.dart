class Receita {
  const Receita({
    required this.id,
    required this.nome,
    this.ingredientes = const [],
    this.instrucoes = const [],
    this.tiposRefeicao = const [],
    this.imagem,
    this.tempoPreparo,
    this.tempoCozimento,
    this.porcoes,
    this.avaliacao,
  });

  final int id;
  final String nome;
  final List<String> ingredientes;
  final List<String> instrucoes;
  final List<String> tiposRefeicao;
  final String? imagem;
  final num? tempoPreparo;
  final num? tempoCozimento;
  final num? porcoes;
  final num? avaliacao;

  num? get tempoTotal {
    if (tempoPreparo == null || tempoCozimento == null) {
      return null;
    }

    return tempoPreparo! + tempoCozimento!;
  }

  factory Receita.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final nome = json['name'];
    final imagem = json['image'];

    if (id is! int ||
        id <= 0 ||
        (nome != null && nome is! String) ||
        (imagem != null && imagem is! String)) {
      throw const FormatException('Receita inválida.');
    }

    return Receita(
      id: id,
      nome: nome is String && nome.trim().isNotEmpty
          ? nome.trim()
          : 'Nome não informado',
      imagem: imagem is String && imagem.trim().isNotEmpty
          ? imagem.trim()
          : null,
      ingredientes: _lerLista(json['ingredients']),
      instrucoes: _lerLista(json['instructions']),
      tiposRefeicao: _lerLista(json['mealType']),
      tempoPreparo: _lerNumero(json['prepTimeMinutes']),
      tempoCozimento: _lerNumero(json['cookTimeMinutes']),
      porcoes: _lerNumero(json['servings']),
      avaliacao: _lerNumero(json['rating']),
    );
  }

  static List<String> _lerLista(dynamic valor) {
    if (valor == null) {
      return [];
    }

    if (valor is! List || valor.any((item) => item is! String)) {
      throw const FormatException('Lista da receita inválida.');
    }

    return List<String>.from(valor);
  }

  static num? _lerNumero(dynamic valor) {
    if (valor == null) {
      return null;
    }

    if (valor is! num || !valor.isFinite || valor < 0) {
      throw const FormatException('Número da receita inválido.');
    }

    return valor;
  }
}