// Importação dos pacotes necessários
import 'package:flutter/material.dart';
import 'general_drawer.dart';
import 'Library.dart';
import 'Book.dart';
import 'Comic.dart';
import 'Magazine.dart';
import 'Newspaper.dart';

// Classe que monta a estrutura básica do app
class ItemsRegister extends StatelessWidget {
  final String? typeOfItem;
  final String idLibrary;
  final String cepLibrary;
  final String nameLibrary;

  const ItemsRegister({
    super.key,
    required this.typeOfItem,
    required this.idLibrary,
    required this.cepLibrary,
    required this.nameLibrary,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Cadastro de $typeOfItem',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        drawer: const AppDrawer(), // Menu lateral
        body: Center(
          child: OverflowBarExample(
            typeOfItem: typeOfItem,
            idLibrary: idLibrary,
            cepLibrary: cepLibrary,
            nameLibrary: nameLibrary,
          ),
        ),
      ),
    );
  }
}

// Tela de cadastro dos itens
class OverflowBarExample extends StatefulWidget {
  final String? typeOfItem;
  final String idLibrary;
  final String cepLibrary;
  final String nameLibrary;

  const OverflowBarExample({
    super.key,
    required this.typeOfItem,
    required this.idLibrary,
    required this.cepLibrary,
    required this.nameLibrary,
  });

  @override
  State<OverflowBarExample> createState() => _OverflowBarExampleState();
}

class _OverflowBarExampleState extends State<OverflowBarExample> {
  // Controladores dos campos de texto
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();

  late Library library;

  @override
  void initState() {
    super.initState();
    // Cria uma instância da biblioteca associada ao item
    library = Library(
      id: widget.idLibrary,
      name: widget.nameLibrary,
      cep: widget.cepLibrary,
    );
  }

  // Função que faz o cadastro do item, dependendo do tipo
  void register() {
    switch (widget.typeOfItem) {
      case 'Livros':
        Book(
          title: controller1.text,
          summary: controller2.text,
          publisher: controller3.text,
          place: library,
          id: "id",
          author: controller4.text,
          nPages: int.tryParse(controller5.text) ?? 0,
        );
        break;
      case 'Revistas':
        Magazine(
          title: controller1.text,
          summary: controller2.text,
          publisher: controller3.text,
          place: library,
          id: "id",
        );
        break;
      case 'Quadrinhos':
        Comic(
          title: controller1.text,
          summary: controller2.text,
          publisher: controller3.text,
          place: library,
          id: "id",
          author: controller4.text,
          artist: controller5.text,
        );
        break;
      case 'Jornais':
        Newspaper(
          title: controller1.text,
          summary: controller2.text,
          publisher: controller3.text,
          place: library,
          id: "id",
          date: DateTime.tryParse(controller4.text) ?? DateTime.now(),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tipo de item não selecionado!')),
        );
    }

    // Mensagem de sucesso
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cadastro realizado'),
        content: const Text('Item cadastrado com sucesso.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Seleção do formulário de acordo com o tipo de item
                ...switch (widget.typeOfItem) {
                  'Livros' => Book.itemRegister(context, controller1, controller2, controller3, controller4, controller5),
                  'Revistas' => Magazine.itemRegister(context, controller1, controller2, controller3),
                  'Quadrinhos' => Comic.itemRegister(context, controller1, controller2, controller3, controller4, controller5),
                  'Jornais' => Newspaper.itemRegister(context, controller1, controller2, controller3, controller4),
                  _ => [const Text('Tipo não selecionado')],
                },

                const SizedBox(height: 20),

                // Botão de cadastro
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: register,            //Não deu tempo de testar um cadastro de itens
                      child: const Text('Cadastrar'), // que nem eu fiz com usuários e bibliotecas, desculpa
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
