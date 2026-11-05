import 'package:flutter/material.dart';

class Pesquisa extends StatefulWidget {
  const Pesquisa({super.key});

  @override
  State<Pesquisa> createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> {
  final nome = TextEditingController();
  String? mensagemErro;


  void validarNome(String valor) {
    setState(() {
      if (valor
          .trim()
          .isEmpty) {
        mensagemErro = "Informe a pesquisa! Espaços vazios não contam como caracter";
      } else if (valor
          .trim()
          .length < 3) {
        mensagemErro = "Informe ao menos 3 caracteres";
      } else {
        mensagemErro = null;
      }
    });
  }

  void Inscrever() {
    validarNome(nome.text);
    if (mensagemErro != null) return;

    final texto = nome.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pesquisa Recebida: $texto"))
    );
    nome.clear();
  }

  @override
  void dispose() {
    nome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: nome, //identificador do input
          decoration: InputDecoration( //Decoração do textField
              labelText: 'Pesquise pela receita',
              errorText: mensagemErro,
              border: const OutlineInputBorder()
          ),
          onChanged: (valor) {
            if (mensagemErro != null) {
              validarNome(valor);
            }
          },
        ),
        const SizedBox(height: 12,),
        FilledButton(onPressed: Inscrever, child: const Text('Pesquisar'),
        ),
      ],
    );
  }
}