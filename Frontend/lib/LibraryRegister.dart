import 'package:apiexemplocall23032025/ItemsRegister.dart';
import 'package:apiexemplocall23032025/Library.dart';
import 'package:flutter/material.dart';
import 'general_drawer.dart';

/// Função principal que roda o app de cadastro de bibliotecas
void LibraryRegister() => runApp(const LibraryRegisterApp());

/// Classe principal do aplicativo
class LibraryRegisterApp extends StatelessWidget {
  const LibraryRegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Center(
                child: Text('Cadastro de Bibliotecas',
                    textAlign: TextAlign.center))),
        drawer: const AppDrawer(),
        body: const Center(child: LibraryRegisterForm()),
      ),
    );
  }
}

/// Classe para representar o endereço da biblioteca
class Address {
  String logradouro = '';
  String numero = '';
  String bairro = '';
  String complemento = '';
  String cidade = '';
  String estado = '';
  String cep = '';

  /// Retorna o endereço como uma string formatada
  @override
  String toString() {
    return '$logradouro; $numero; $bairro; $complemento; $cidade; $estado; $cep';
  }

  /// Retorna o endereço como uma lista de strings
  List<String> toList() {
    return [logradouro, numero, bairro, complemento, cidade, estado, cep];
  }
}

/// Tela do formulário de cadastro
class LibraryRegisterForm extends StatefulWidget {
  const LibraryRegisterForm({super.key});

  @override
  State<LibraryRegisterForm> createState() => _LibraryRegisterFormState();
}

class _LibraryRegisterFormState extends State<LibraryRegisterForm> {
  /// Nome da biblioteca
  String nome = '';

  /// Endereço da biblioteca (objeto Address)
  Address endereco = Address();

  /// Lista de bibliotecas cadastradas (mock para exemplo)
  final Map<String, List<String>> listaTeste = {
    'Alexandria': [
      'Rua dos bobos',
      '0',
      'Jardim Otários',
      'A esquerda do papa Leão 4',
      'Estado',
      'CI',
      '10'
    ]
  };

  /// Checa se a biblioteca já existe na lista
  Future<bool> checarBiblioteca(String nome, Address endereco) async {
    bool bibliotecaExiste = true;

    for (var entry in listaTeste.entries) {
      // Verifica se o nome é igual e se o endereço é igual
      if (entry.key == nome &&
          _enderecosSaoIguais(entry.value, endereco.toList())) {
        var library = Library(id: "id", name: entry.key, cep: entry.value.last);

        // Mostra o diálogo informando que a biblioteca já existe
        await _mostrarDialogoBibliotecaExiste(library);
        bibliotecaExiste = false;
        break;
      }
    }
    return bibliotecaExiste;
  }

  /// Compara se dois endereços (listas de strings) são iguais
  bool _enderecosSaoIguais(List<String> e1, List<String> e2) {
    if (e1.length != e2.length) return false;
    for (int i = 0; i < e1.length; i++) {
      if (e1[i] != e2[i]) return false;
    }
    return true;
  }

  /// Mostra o diálogo caso a biblioteca já exista
  Future<void> _mostrarDialogoBibliotecaExiste(Library library) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Biblioteca já existente.'),
        content: const Text('Gostaria de adicionar um item nela?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cadastrar item');
              library.addInLibrary(context); // Chama o cadastro de item
            },
            child: const Text('Cadastrar item'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancelar');
            },
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  /// Faz o cadastro da biblioteca
  Future<void> fazerCadastro() async {
    // Checa se já existe
    bool podeCadastrar = await checarBiblioteca(nome, endereco);

    if (podeCadastrar) {
      // Se não existir, adiciona na lista
      setState(() {
        listaTeste[nome] = endereco.toList();
      });

      Library library =
          Library(id: "id", name: nome, cep: endereco.cep);

      // Mostra um diálogo de sucesso e oferece cadastrar itens
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Biblioteca cadastrada com sucesso.'),
          content: const Text('Gostaria de adicionar um item nela?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cadastrar item');
                library.addInLibrary(context);
              },
              child: const Text('Cadastrar item'),
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

  /// Cria um TextField configurado
  Widget buildTextField(String label, void Function(String) onChanged) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
    );
  }

  /// Monta a interface da tela
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      color: Colors.black.withOpacity(0.15),
      child: Material(
        color: Colors.white,
        elevation: 24,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Campos do formulário
                buildTextField('Nome:', (value) => nome = value),
                buildTextField('Logradouro:', (value) => endereco.logradouro = value),
                buildTextField('Número:', (value) => endereco.numero = value),
                buildTextField('Bairro:', (value) => endereco.bairro = value),
                buildTextField('Complemento:', (value) => endereco.complemento = value),
                buildTextField('Cidade:', (value) => endereco.cidade = value),
                buildTextField('Estado:', (value) => endereco.estado = value),
                buildTextField('CEP:', (value) => endereco.cep = value),

                const SizedBox(height: 20),

                // Botão de cadastro
                Row(
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: fazerCadastro,
                      child: const Text('Cadastrar'),
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
