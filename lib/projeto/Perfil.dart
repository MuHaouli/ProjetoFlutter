import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagina de Receitas"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.orange[200],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.orange)
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(child: Icon(Icons.person),),
                  SizedBox(width: 16,),
                  Expanded(child: Text(
                    'Bolo De cenoura',
                    style: TextStyle(fontSize: 20),
                    )
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text("Veja o passo a passo aqui:"),
              SizedBox(height: 8,),
            ],
          ),
        ),
      ),
    );
  }
}
