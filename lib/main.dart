import 'package:flutter/material.dart';

import 'Ajout.dart';
import 'Connexion.dart';
import 'affichageUtilisateur.dart';

void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({super.key});

  static const String _title = 'Quizz';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notre application de quizz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const Connexion(),
        '/liste': (context) => const Affichage(),
        '/ajout': (context) => const Ajout(),
      },
    );
  }
}
