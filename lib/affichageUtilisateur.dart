import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/question.dart';

import 'Modifier.dart';

class Affichage extends StatefulWidget {
  const Affichage({Key? key}) : super(key: key);

  @override
  State<Affichage> createState() => _AffichageState();
}

class _AffichageState extends State<Affichage> {
  late Future<List> _question;

  @override
  void initState() {
    super.initState();
    _question = Question.getAllQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des questions"),
      ),
      body: FutureBuilder<List>(
        future: _question,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            snapshot.data![i]['question'].toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            snapshot.data![i]['reponse'].toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0, top: 0, bottom: 0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Modifier(
                                                id: int.parse(snapshot.data![i]
                                                        ["id"]
                                                    .toString()))),
                                      );
                                    },
                                    child: const Icon(Icons.edit)),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: 200,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text(
                                                    'Êtes-vous sûr de vouloir supprimer cette question ? '),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15.0,
                                                                right: 15.0,
                                                                top: 15.0,
                                                                bottom: 0),
                                                        child: ElevatedButton(
                                                            child: const Text(
                                                                'Oui'),
                                                            onPressed: () {
                                                              Question.Delete(
                                                                  context,
                                                                  int.parse(snapshot
                                                                      .data![i]
                                                                          ["id"]
                                                                      .toString()));
                                                            }),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 15.0,
                                                                right: 15.0,
                                                                top: 15.0,
                                                                bottom: 0),
                                                        child: ElevatedButton(
                                                          child:
                                                              const Text('Non'),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                        ),
                                                      )
                                                    ]),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.delete)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text("Pas de données"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/ajout');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
