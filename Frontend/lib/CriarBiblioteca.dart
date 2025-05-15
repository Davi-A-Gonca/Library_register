import 'package:flutter/material.dart';

void main() => runApp(const OverflowBarExampleApp());

class OverflowBarExampleApp extends StatelessWidget {
  const OverflowBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Center(child: Text('Cadastro de Bibliotecas', textAlign: TextAlign.center))),
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
  String nome = '';
  String logradouro = '';
  String numero = '';
  String bairro = '';
  String complemento = '';
  String cidade = '';
  String estado = '';
  String cep = '';
  String endereco = '';
  final Map<String, List<String>> listaTeste = {'Alexandria': ['Rua dos bobos',
                                                   '0', 'Jardim Otários',
                                                   'A esquerda do papa Leão 4',
                                                   'Estado', 'CI', '10']};

  Future<String> gerarEndereco(String logradouro, String numero, String bairro, String complemento, String cidade, String estado, String cep) async{
    String endereco = logradouro + '; ' + numero + '; ' + bairro + '; ' + complemento + '; ' + cidade + '; ' + estado + '; ' + cep;
    return endereco;
  }
  
  Future<bool> checarBiblioteca(String nome, String endereco) async {
    List<String> enderecoSeparado = endereco.split('; ');
    bool bibliotecaExiste = true;
    int check = 0;
    
    for (var lista in listaTeste.entries){
      List<String> v = lista.value;
      check = 0;
      if(lista.key == nome){
        for(int i = 0; i < v.length; i++){
          if(v[i] == enderecoSeparado[i])
            check++;
        }
        if(check == v.length){
          await showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Biblioteca já existente.'),
              content: const Text('Gostaria de adicionar um livro nela?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cadastrar livro');
                  },
                  child: const Text('Cadastrar livro'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cadastrar biblioteca');
                  },
                  child: const Text('Cadastrar biblioteca'),
                ),
              ],
            ),
          );
          bibliotecaExiste = false;
        };
      }
    };
    return bibliotecaExiste;
  }
  
  Future<void> fazerCadastro(String nome, String endereco) async {
    listaTeste.forEach((k,v){print(k);print(v);});
    bool bibliotecaExiste = await checarBiblioteca(nome, endereco);
    List<String> enderecoSeparado = endereco.split('; ');
    if(bibliotecaExiste){
      setState((){
        listaTeste[nome] = enderecoSeparado;
      });
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Biblioteca cadastrada com sucesso.'),
            content: const Text('Gostaria de adicionar um livro nela?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cadastrar livro');
                },
                child: const Text('Cadastrar livro'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cadastrar outra biblioteca');
                },
                child: const Text('Cadastrar outra biblioteca'),
              ),
            ],
          ),
        );
      }
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
                  onChanged: (String? value) {
                    setState(() {
                      nome = value ?? '';
                    });
                  }
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Endereco:'),
                  onChanged: (String? value) {
                    setState(() {
                      logradouro = value ?? '';
                    });
                  }
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Numero:'),
                  onChanged: (String? value) {
                    setState(() {
                      numero = value ?? '';
                    });
                  }
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Bairro:'),
                  onChanged: (String? value) {
                    setState(() {
                      bairro = value ?? '';
                    });
                  }
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Complemento:'),
                  onChanged: (String? value) {
                    setState(() {
                      complemento = value ?? '';
                    });
                  }
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Cidade:'),
                  onChanged: (String? value) {
                    setState(() {
                      cidade = value ?? '';
                    });
                  }
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Estado:'),
                  onChanged: (String? value) {
                    setState(() {
                      estado = value ?? '';
                    });
                  }
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'CEP:'),
                  onChanged: (String? value) {
                    setState(() {
                      cep = value ?? '';
                    });
                  }
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () async{
                        endereco = await gerarEndereco(logradouro, numero, bairro, complemento, cidade, estado, cep);
                        await fazerCadastro(nome, endereco);
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