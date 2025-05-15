import 'package:flutter/material.dart';

void main() => runApp(const OverflowBarExampleApp());

class OverflowBarExampleApp extends StatelessWidget {
  const OverflowBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Center(child: Text('Cadastro de livros', textAlign: TextAlign.center))),
        body: const Center(child: OverflowBarExample()),
      ),
    );
  }
}

class OverflowBarExample extends StatefulWidget {
  const OverflowBarExample({super.key});

  @override
  State<OverflowBarExample> createState() => _OverflowBarExampleState();
}

class _OverflowBarExampleState extends State<OverflowBarExample> {
  bool cadastro = false;
  String nome = '';
  String autor = '';
  String categoria = '';
  int numeroPaginas = 0;
  final Map<String, List<String>> listaTeste = {'livro':
  ['autor',
   'categoria',
   '10']};

  Future<bool> checarLivro(String nome, String autor, String categoria, int paginas) async {
    bool livroExiste = false;
    int check = 0;
    for (var lista in listaTeste.entries){
      List<String> v = lista.value;
      check = 0;
      if(lista.key == nome){
        for(int i = 0; i < v.length; i++){
          if(v[0] == autor && v[1] == categoria && v[2] == paginas.toString()){
            check++;
          }
        }
        if(check == v.length){
          await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Livro já existente nessa biblioteca.'),
              content: const Text('Gostaria de alterar a biblioteca?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cadastrar livro');
                  },
                  child: const Text('Cadastrar outro livro'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cadastrar biblioteca diferente');
                  },
                  child: const Text('Cadastrar esse livro em outra biblioteca'),
                ),
              ],
            ),
          );
          livroExiste = true;
        };
      }
    }
    return livroExiste;
  }

  Future<void> fazerCadastro(String nome, String autor, String categoria, int paginas) async {
    bool livroExiste = await checarLivro(nome, autor, categoria, paginas);
    if(!livroExiste)
      listaTeste[nome] = [autor, categoria, paginas.toString()];
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
                  }
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Autor:'),
                  onChanged: (String value) {
                    setState(() {
                      autor = value;
                    });
                  }
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Categoria:'),
                  onChanged: (String value) {
                    setState(() {
                      categoria = value;
                    });
                  }
                ),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Número de Páginas:'),
                  onChanged: (String value) {
                    setState(() {
                      numeroPaginas = int.tryParse(value) ?? 0;
                    });
                  }
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        fazerCadastro(nome, autor, categoria, numeroPaginas);
                      },
                      child: const Text('Cadastro'),
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