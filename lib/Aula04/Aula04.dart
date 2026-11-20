import 'package:flutter/material.dart';
import 'package:receito/Aula04/Guia.dart';

class Aula04 extends StatelessWidget {
  const Aula04({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Guia(),
    );
  }
}
