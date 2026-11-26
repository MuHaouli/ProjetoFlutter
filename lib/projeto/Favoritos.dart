import 'package:flutter/material.dart';

import 'DetalhesReceita.dart';
import 'Receita.dart';

class Favoritos extends StatefulWidget {
  const Favoritos({
    super.key,
    required this.favoritos,
  });

  final List<Receita> favoritos;

  @override
  State<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  Future<void> abrirDetalhes(Receita receita) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => DetalhesReceita(
          receita: receita,
          favoritos: widget.favoritos,
        ),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus favoritos'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Seus favoritos',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            if (widget.favoritos.isEmpty) ...[
              const Icon(
                Icons.favorite_border,
                size: 64,
                color: Colors.orange,
              ),

              const SizedBox(height: 20),

              const Text(
                'Você ainda não adicionou receitas aos favoritos.',
                textAlign: TextAlign.center,
              ),
            ] else ...[
              const Text(
                'Disponíveis enquanto o app estiver aberto.',
              ),

              const SizedBox(height: 12),

              for (final receita in widget.favoritos)
                Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    key: ValueKey('favorita-${receita.id}'),
                    contentPadding: const EdgeInsets.all(12),

                    leading: SizedBox(
                      width: 56,
                      height: 56,
                      child: receita.imagem == null
                          ? const Icon(
                        Icons.restaurant_menu,
                        size: 40,
                      )
                          : Image.network(
                        receita.imagem!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return const Icon(
                            Icons.restaurant_menu,
                            size: 40,
                          );
                        },
                      ),
                    ),

                    title: Text(
                      receita.nome,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    trailing: IconButton(
                      tooltip: 'Remover dos favoritos',
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.favoritos.removeWhere(
                                (item) => item.id == receita.id,
                          );
                        });
                      },
                    ),

                    onTap: () {
                      abrirDetalhes(receita);
                    },
                  ),
                ),
            ],

            const SizedBox(height: 24),

            FilledButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: const Text('Voltar às receitas'),
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