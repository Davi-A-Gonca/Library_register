import 'package:flutter/material.dart';
import 'ItemsRegister.dart';

class Library {
  final String id;
  final String name;
  final String cep;

  Library({
    required this.id,
    required this.name,
    required this.cep,
  });

  String getName() => name;
  String getCep() => cep;

  /// Widget que exibe informações da biblioteca
  Widget itemInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('CEP: $cep'),
      ],
    );
  }

  /// Cria os campos para cadastro de biblioteca
  static List<Widget> itemRegister(
    BuildContext context, //Talvez esse não precise, mas fiquei com medo de alguma coisa dar errado então deixei aqui
    TextEditingController nameController,
    TextEditingController cepController,
  ) {
    return [
      _buildTextField('Nome da biblioteca:', nameController),
      _buildTextField('CEP:', cepController),
    ];
  }

  /// Widget auxiliar para criar campos de texto
  static Widget _buildTextField(
    String label,
    TextEditingController controller,
  ) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
    );
  }

  /// Abre o diálogo para escolher o item a ser cadastrado na biblioteca
  Future<String?> addInLibrary(BuildContext context) async {
    String? opcao;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Qual item gostaria de cadastrar na Biblioteca?'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: Text('Livros'),
                    value: 'Livros',
                    groupValue: opcao,
                    onChanged: (newValue) {
                      setState(() {
                        opcao = newValue;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Revistas'),
                    value: 'Revistas',
                    groupValue: opcao,
                    onChanged: (newValue) {
                      setState(() {
                        opcao = newValue;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Quadrinhos'),
                    value: 'Quadrinhos',
                    groupValue: opcao,
                    onChanged: (newValue) {
                      setState(() {
                        opcao = newValue;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Jornais'),
                    value: 'Jornais',
                    groupValue: opcao,
                    onChanged: (newValue) {
                      setState(() {
                        opcao = newValue;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, opcao);
                    if (opcao != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemsRegister(
                            typeOfItem: opcao!,
                            idLibrary: id,
                            cepLibrary: cep,
                            nameLibrary: name,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Cadastrar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
