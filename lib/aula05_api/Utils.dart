
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'Publicacao.dart';

//jsonplaceholder.typicode.com
Future<List<Publicacao>> carregar() async{
  final resposta = await http.get(Uri.https('jsonplaceholder.typicode.com', '/posts',)
  ).timeout(const Duration(seconds:10));

  if(resposta.statusCode !=200){
    throw Exception('HTTP ${resposta.statusCode}');
  }

  final dados = jsonDecode(resposta.body);
  if(dados is! List) throw FormatException('Lista Esperada');

  return dados.map((item){
    if(dados is! Map<String, dynamic>){
      throw const FormatException("Formato Inválido");
    }
    return Publicacao.fromJson(item);
  }).toList();
}