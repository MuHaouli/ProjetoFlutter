import 'package:flutter/material.dart';

class Favoritos extends StatelessWidget {
  const Favoritos({super.key});

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
            const SizedBox(height: 24),

            const Icon(
              Icons.favorite_border,
              size: 64,
              color: Colors.orange,
            ),

            const SizedBox(height: 20),

            const Text(
              'Seus favoritos',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Suas receitas favoritas aparecerão aqui.',
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            FilledButton.icon(
              key: const ValueKey('voltar-favoritos'),
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