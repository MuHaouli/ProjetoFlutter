import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Receita.dart';

Future<List<Receita>> carregar([String pesquisa = '']) async {
  final termo = pesquisa.trim();

  final Uri url;

  if (termo.isEmpty) {
    url = Uri.https(
      'dummyjson.com',
      '/recipes',
      {'limit': '30'},
    );
  } else {
    url = Uri.https(
      'dummyjson.com',
      '/recipes/search',
      {
        'q': termo,
        'limit': '30',
      },
    );
  }

  final resposta = await http
      .get(url)
      .timeout(const Duration(seconds: 20));

  if (resposta.statusCode != 200) {
    throw Exception('Não foi possível carregar as receitas.');
  }

  final dados = jsonDecode(resposta.body);

  if (dados is! Map<String, dynamic>) {
    throw const FormatException('Resposta da API inválida.');
  }

  final itens = dados['recipes'];

  if (itens is! List) {
    throw const FormatException('Lista de receitas inválida.');
  }

  // Transforma cada item recebido em um objeto Receita.
  final receitas = <Receita>[];

  for (final item in itens) {
    if (item is! Map<String, dynamic>) {
      throw const FormatException('Receita inválida.');
    }

    receitas.add(Receita.fromJson(item));
  }

  return receitas;
}