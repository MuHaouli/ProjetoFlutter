import 'package:flutter/material.dart';
import 'package:receito/Aula04/DetalheLugar.dart';
import 'package:receito/Aula04/Lugar.dart';

class Guia extends StatelessWidget {
  const Guia({super.key});

  @override
  Widget build(BuildContext context) {
    const lugar = Lugar(
        "Jardim Botanico",
        "Trilhas e espaços verdes");

    const lugar2 = Lugar(
        "Jardim Botanico",
        null);

    return Scaffold(
      appBar: AppBar(title: const Text("Guia da cidade"),),
      body: Center(
        child: FilledButton(
          child: Text(lugar.nome),
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (_)=> Detalhelugar(lugar:lugar)
            ));
            },
      ),
      ),
    );
  }
}
