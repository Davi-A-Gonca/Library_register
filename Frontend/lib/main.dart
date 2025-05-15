import 'package:flutter/material.dart';

void main() => runApp(const OverflowBarExampleApp());

class OverflowBarExampleApp extends StatelessWidget {
  const OverflowBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Center(child: Text('Login/Cadastro', textAlign: TextAlign.center))),
        body: const Center(child: OverflowBarExample()),
      ),
    );
  }
}

class OverflowBarExample extends StatefulWidget {
  const OverflowBarExample({super.key});

  @override
  _OverflowBarExampleState createState() => _OverflowBarExampleState();
}

class _OverflowBarExampleState extends State<OverflowBarExample> {
  bool cadastro = false;
  String nome = '';
  String senha = '';
  final Map<String, String> listaTeste = {'nome': 'senha'};

  Future<void> fazerLogin(String nome, String senha) async {
    bool loggedIn = false;
    listaTeste.forEach((k, v) {
      if (nome == k && senha == v) {
        loggedIn = true;
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Deu tudo certo'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });

    if (!loggedIn) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Nome ou senha errados ou não cadastrados'),
          content: const Text('Gostaria de cadastrar?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cadastrar');
                fazerCadastro(nome, senha);
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> fazerCadastro(String nome, String senha) async {
    listaTeste[nome] = senha;
    setState(() {
      cadastro = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      color: Colors.black.withOpacity(0.15),
      child: Material(
        color: Colors.white,
        elevation: 24,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Nome:'),
                  onChanged: (String value) {
                    setState(() {
                      nome = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha:'),
                  onChanged: (String value) {
                    setState(() {
                      senha = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    if (!cadastro)
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              cadastro = true;
                            });
                          },
                          child: const Text('Cadastro')),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        if (cadastro) {
                          fazerCadastro(nome, senha);
                        } else {
                          fazerLogin(nome, senha);
                        }
                      },
                      child: const Text('Continuar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}