import 'package:flutter/material.dart';
import 'package:receito/Aula04/Lugar.dart';

class Detalhelugar extends StatelessWidget {
  const Detalhelugar({super.key, required this.lugar});
  final Lugar lugar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lugar.nome)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(lugar.descricao ?? 'Descrição Indisponível'),
            const SizedBox(height: 20,),
            OutlinedButton(
                child: const Text("Voltar a tela Guia"),
                onPressed: (){
                  Navigator.pop(context);
                },
            ),
          ],
        ),
      ),
    );
  }
}
