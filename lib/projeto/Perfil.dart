import 'package:flutter/material.dart';

import 'Pesquisa.dart';
import 'DetalhesReceita.dart';
import 'Favoritos.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receito'),
      ),
      body: SingleChildScrollView(
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

            // Componente de pesquisa dentro da página.
            const Pesquisa(),

            const SizedBox(height: 24),

            // Área reservada para os dados futuros.
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.orange.shade200,
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    size: 48,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'As receitas serão exibidas aqui.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            FilledButton.icon(
              key: const ValueKey('abrir-detalhes'),
              icon: const Icon(Icons.description_outlined),
              label: const Text('Abrir detalhes'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const DetalhesReceita(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              key: const ValueKey('abrir-favoritos'),
              icon: const Icon(Icons.favorite_border),
              label: const Text('Meus favoritos'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const Favoritos(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}