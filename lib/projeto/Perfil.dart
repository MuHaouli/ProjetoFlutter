import 'package:flutter/material.dart';

import 'Pesquisa.dart';
import 'DetalhesReceita.dart';
import 'Favoritos.dart';
import 'Receita.dart';
import 'Utils/Request.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  late Future<List<Receita>> receitas;

  final List<Receita> favoritos = [];
  final rolagem = ScrollController();

  String consulta = '';
  bool carregando = true;

  @override
  void initState() {
    super.initState();

    receitas = buscarReceitas();
  }

  Future<List<Receita>> buscarReceitas() async {
    try {
      return await carregar(consulta);
    } finally {
      if (mounted) {
        setState(() {
          carregando = false;
        });
      }
    }
  }

  void pesquisar(String texto) {
    if (carregando) return;

    setState(() {
      consulta = texto.trim();
      carregando = true;
      receitas = buscarReceitas();
    });

    if (rolagem.hasClients) {
      rolagem.jumpTo(0);
    }
  }

  bool ehFavorita(Receita receita) {
    return favoritos.any((item) => item.id == receita.id);
  }

  void alternarFavorito(Receita receita) {
    setState(() {
      if (ehFavorita(receita)) {
        favoritos.removeWhere(
              (item) => item.id == receita.id,
        );
      } else {
        favoritos.add(receita);
      }
    });
  }

  Future<void> abrirDetalhes(Receita receita) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => DetalhesReceita(
          receita: receita,
          favoritos: favoritos,
        ),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> abrirFavoritos() async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => Favoritos(
          favoritos: favoritos,
        ),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    rolagem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saborê'),
        actions: [
          IconButton(
            key: const ValueKey('abrir-favoritos'),
            tooltip: 'Meus favoritos',
            icon: const Icon(Icons.favorite_border),
            onPressed: abrirFavoritos,
          ),
        ],
      ),

      body: SingleChildScrollView(
        controller: rolagem,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Receitas',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Pesquisa(
              carregando: carregando,
              aoPesquisar: pesquisar,
              aoLimpar: () => pesquisar(''),
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: abrirFavoritos,
              icon: const Icon(Icons.favorite_border),
              label: Text(
                'Meus favoritos (${favoritos.length})',
              ),
            ),

            const SizedBox(height: 24),

            Text(
              consulta.isEmpty
                  ? 'Lista de receitas'
                  : 'Resultados para: $consulta',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            FutureBuilder<List<Receita>>(
              future: receitas,
              builder: (context, estado) {
                if (estado.connectionState != ConnectionState.done) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 12),
                        Text('Carregando receitas...'),
                      ],
                    ),
                  );
                }

                if (estado.hasError) {
                  return Column(
                    children: [
                      const Text(
                        'Não foi possível carregar as receitas. '
                            'Verifique sua conexão e tente novamente.',
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 12),

                      FilledButton(
                        onPressed: carregando
                            ? null
                            : () => pesquisar(consulta),
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  );
                }

                final itens = estado.data ?? <Receita>[];

                if (itens.isEmpty) {
                  return Text(
                    consulta.isEmpty
                        ? 'Nenhuma receita disponível.'
                        : 'Nenhuma receita encontrada. Tente outro nome.',
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: itens.length,
                  itemBuilder: (context, i) {
                    final receita = itens[i];
                    final favorita = ehFavorita(receita);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        key: ValueKey('receita-${receita.id}'),
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

                        subtitle: const Text(
                          'Ver ingredientes e preparo',
                        ),

                        trailing: IconButton(
                          key: ValueKey('favoritar-${receita.id}'),
                          tooltip: favorita
                              ? 'Remover dos favoritos'
                              : 'Favoritar',
                          icon: Icon(
                            favorita
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            alternarFavorito(receita);
                          },
                        ),

                        onTap: () {
                          abrirDetalhes(receita);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}