import 'package:flutter/material.dart';

import 'Receita.dart';

class DetalhesReceita extends StatefulWidget {
  const DetalhesReceita({
    super.key,
    required this.receita,
    required this.favoritos,
  });

  final Receita receita;
  final List<Receita> favoritos;

  @override
  State<DetalhesReceita> createState() => _DetalhesReceitaState();
}

class _DetalhesReceitaState extends State<DetalhesReceita> {
  bool get favorita {
    return widget.favoritos.any(
          (item) => item.id == widget.receita.id,
    );
  }

  void alternarFavorito() {
    setState(() {
      if (favorita) {
        widget.favoritos.removeWhere(
              (item) => item.id == widget.receita.id,
        );
      } else {
        widget.favoritos.add(widget.receita);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final receita = widget.receita;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da receita'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 220,
              child: receita.imagem == null
                  ? const Icon(
                Icons.restaurant_menu,
                size: 80,
              )
                  : Image.network(
                receita.imagem!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.restaurant_menu,
                    size: 80,
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Text(
              receita.nome,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'Preparo: ${receita.tempoPreparo == null ? 'Não informado' : '${receita.tempoPreparo} min'}',
            ),

            Text(
              'Cozimento: ${receita.tempoCozimento == null ? 'Não informado' : '${receita.tempoCozimento} min'}',
            ),

            if (receita.tempoTotal != null)
              Text(
                'Tempo total: ${receita.tempoTotal} min',
              ),

            if (receita.porcoes != null && receita.porcoes! > 0)
              Text(
                'Porções: ${receita.porcoes}',
              ),

            if (receita.avaliacao != null)
              Text(
                'Avaliação: ${receita.avaliacao} / 5',
              ),

            if (receita.tiposRefeicao.isNotEmpty)
              Text(
                'Tipo de refeição: ${receita.tiposRefeicao.join(', ')}',
              ),

            const SizedBox(height: 20),

            OutlinedButton.icon(
              key: const ValueKey('favoritar-detalhes'),
              onPressed: alternarFavorito,
              icon: Icon(
                favorita
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              label: Text(
                favorita
                    ? 'Remover dos favoritos'
                    : 'Adicionar aos favoritos',
              ),
            ),

            const Divider(height: 40),

            const Text(
              'Ingredientes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (receita.ingredientes.isEmpty)
              const Text('Ingredientes não informados.')
            else
              for (final ingrediente in receita.ingredientes)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('• $ingrediente'),
                ),

            const Divider(height: 40),

            const Text(
              'Modo de preparo',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (receita.instrucoes.isEmpty)
              const Text('Instruções não informadas.')
            else
              for (int i = 0; i < receita.instrucoes.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${i + 1}. ${receita.instrucoes[i]}',
                  ),
                ),

            const SizedBox(height: 24),

            FilledButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text('Voltar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}