import 'package:apiexemplocall23032025/ItemsRegister.dart';
import 'package:apiexemplocall23032025/InteractionsAPI.dart';
import 'package:apiexemplocall23032025/Library.dart';
import 'package:flutter/material.dart';
import 'InteractionsCEP.dart';
import 'Library.dart';
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

  Address.fromMap(Map<String, dynamic> map) {
    logradouro = map['logradouro'] ?? '';
    bairro = map['bairro'] ?? '';
    complemento = map['complemento'] ?? '';
    cidade = map['localidade'] ?? '';
    estado = map['uf'] ?? '';
    cep = map['cep'] ?? '';
    numero = ''; // API não retorna número, geralmente precisa ser preenchido manualmente
  }

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
  ///Lista de bibliotecas
  List<Library> existingLybraries = [];

  /// Nome da biblioteca
  String nome = '';

  //CEP da biblioteca
  String cep = '';

  //Controllers
  TextEditingController nomeController = new TextEditingController();
  TextEditingController logradouroController = new TextEditingController();
  TextEditingController numeroController = new TextEditingController();
  TextEditingController bairroController = new TextEditingController();
  TextEditingController complementoController = new TextEditingController();
  TextEditingController cidadeController = new TextEditingController();
  TextEditingController estadoController = new TextEditingController();
  TextEditingController cepController = new TextEditingController();

  //Listar Bibliotecas
  Future<void> listLibraries() async{
    List<Library> placeholderLibrary = await Interactionsapi.getLibraries();
    setState(() {
      existingLybraries = placeholderLibrary;
    });
  }

@override
void initState() {
  super.initState();
  listLibraries();
}

  /// Checa se a biblioteca já existe na lista
  Future<bool> checarBiblioteca(String nome, String cep) async {
    bool bibliotecaExiste = true;

    //Checar Biblioteca Por Biblioteca na lista
    existingLybraries.forEach((library){
      if(library.cep == cep || library.name == nome){
        _mostrarDialogoBibliotecaExiste(library);
        bibliotecaExiste = false;
        return;
      }
    });
    return bibliotecaExiste;
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
    bool podeCadastrar = await checarBiblioteca(nome, cep);

    if (podeCadastrar) {
      Library newLibrary = new Library(id: "1", name: nome, cep: cep);
      existingLybraries.add(newLibrary);

      Interactionsapi.sendLibrary(newLibrary);
      
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
                newLibrary.addInLibrary(context);
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
  Widget buildTextField(String label, TextEditingController controller, void Function(String) onChanged) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      onChanged: onChanged,
    );
  }

  //Colocar o endereço nos campos de cadastro
  Future<void> adressUpdate(cep) async{
    Address address = await InteractionsCEP.searchCEP(cep);
    setState((){
      logradouroController.text = address.logradouro;
      numeroController.text = address.numero;
      bairroController.text = address.bairro;
      complementoController.text = address.complemento;
      cidadeController.text = address.cidade;
      estadoController.text = address.estado;
    });
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
                buildTextField('Nome:', nomeController, (value) => nome = value),
                buildTextField('Logradouro:', logradouroController, (value) {}),
                buildTextField('Número:', numeroController, (value) {}),
                buildTextField('Bairro:', bairroController, (value) {}),
                buildTextField('Complemento:', complementoController, (value) {}),
                buildTextField('Cidade:', cidadeController, (value) {}),
                buildTextField('Estado:', estadoController, (value) {}),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: buildTextField('CEP:', cepController, (value) => cep = value),
                    ),
                    const SizedBox(width: 8), // Espaçamento entre campo e botão
                    OutlinedButton(
                      onPressed: () {
                        adressUpdate(cepController.text); // Use o valor do controller, não da variável `cep`
                      },
                      child: const Text('Pesquisar CEP?'),
                    ),
                  ],
                ),

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