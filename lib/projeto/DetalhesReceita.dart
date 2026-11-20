import 'package:flutter/material.dart';

class DetalhesReceita extends StatelessWidget {
  const DetalhesReceita({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da receita'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Informações da receita',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text('Nenhuma receita selecionada.'),

            const Divider(height: 40),

            const Text(
              'Ingredientes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text('Os ingredientes serão exibidos aqui.'),

            const Divider(height: 40),

            const Text(
              'Modo de preparo',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text('As instruções serão exibidas aqui.'),

            const SizedBox(height: 32),

            OutlinedButton.icon(
              onPressed: null,
              icon: const Icon(Icons.favorite_border),
              label: const Text('Adicionar aos favoritos'),
            ),

            const SizedBox(height: 12),

            FilledButton.icon(
              key: const ValueKey('voltar-detalhes'),
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