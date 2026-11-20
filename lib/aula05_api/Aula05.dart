import 'package:flutter/material.dart';

import 'Mural.dart';

class Aula05 extends StatelessWidget {
  const Aula05({super.key});

  //jsonplaceholder.typicode.com

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mural(),
    );
  }
}
