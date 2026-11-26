import 'package:flutter/material.dart';

class Pesquisa extends StatefulWidget {
  const Pesquisa({
    super.key,
    required this.aoPesquisar,
    required this.aoLimpar,
    required this.carregando,
  });

  final ValueChanged<String> aoPesquisar;
  final VoidCallback aoLimpar;
  final bool carregando;

  @override
  State<Pesquisa> createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> {
  final nome = TextEditingController();

  String? mensagemErro;

  void pesquisar() {
    if (widget.carregando) return;

    final texto = nome.text.trim();

    setState(() {
      mensagemErro = texto.isEmpty
          ? 'Informe o nome de uma receita.'
          : null;
    });

    if (mensagemErro != null) return;

    FocusScope.of(context).unfocus();

    widget.aoPesquisar(texto);

    // O texto continua no campo para preservar a consulta.
  }

  void limpar() {
    if (widget.carregando) return;

    nome.clear();

    setState(() {
      mensagemErro = null;
    });

    FocusScope.of(context).unfocus();

    widget.aoLimpar();
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
          controller: nome,
          enabled: !widget.carregando,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            labelText: 'Pesquise pela receita',
            errorText: mensagemErro,
            errorMaxLines: 3,
            border: const OutlineInputBorder(),
          ),
          onSubmitted: (_) => pesquisar(),
          onChanged: (_) {
            if (mensagemErro != null) {
              setState(() {
                mensagemErro = null;
              });
            }
          },
        ),

        const SizedBox(height: 12),

        FilledButton.icon(
          onPressed: widget.carregando ? null : pesquisar,
          icon: const Icon(Icons.search),
          label: const Text('Pesquisar'),
        ),

        OutlinedButton(
          onPressed: widget.carregando ? null : limpar,
          child: const Text('Limpar pesquisa e ver receitas'),
        ),
      ],
    );
  }
}