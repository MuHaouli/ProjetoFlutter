import 'package:flutter/material.dart';

class Pesquisa extends StatefulWidget {
  const Pesquisa({super.key});

  @override
  State<Pesquisa> createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> {
  final nome = TextEditingController();
  String? mensagemErro;


  void validarNome(String valor){
    setState(() {

      if(valor.trim().isEmpty){
        mensagemErro = "Informe a pesquisa!";
      } else if(valor.trim().length < 3){
        mensagemErro = "Informe ao menos 3 caracteres";
      } else{
        mensagemErro = null;
      }
    });
  }

  void Inscrever(){
    validarNome(nome.text);
    if(mensagemErro != null) return;

    final texto = nome.text.trim();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Inscrição Recebida: $texto"))
    );
    nome.clear();
  }

  @override
  void dispose(){
    nome.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Palestra")
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: nome, //identificador do input
              decoration: InputDecoration( //Decoração do textField
                  labelText: 'Pesquise pela receita',
                  errorText: mensagemErro,
                  border: const OutlineInputBorder()
              ),
              onChanged: (valor){
                if (mensagemErro != null) validarNome(valor);
              },
            ),
            FilledButton(onPressed: Inscrever, child: Text('Pesquisar'))
          ],
        ),
      ),
    );
  }
}
