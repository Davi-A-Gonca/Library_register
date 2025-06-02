import 'package:apiexemplocall23032025/Library.dart';
import 'package:apiexemplocall23032025/PaperMedia.dart';
import 'package:flutter/material.dart';
import 'Standardizer.dart';

class Magazine extends Papermedia implements Standardizer{
  final String id;

  Magazine({
    required String title,
    required String summary,
    required String publisher,
    required Library place,
    required this.id,
  }) : super(
          title: title,
          summary: summary,
          publisher: publisher,
          place: place,
        );

  /// Widget para exibir informações da revista
  Widget itemInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('Sinopse: $summary'),
        Text('Editora: $publisher'),
      ],
    );
  }

  /// Campos para cadastro de revista
  static List<Widget> itemRegister(
    BuildContext context, //Talvez esse não precise, mas fiquei com medo de alguma coisa dar errado então deixei aqui
    TextEditingController titleController,
    TextEditingController summaryController,
    TextEditingController publisherController,
  ) {
    return [
      _buildTextField('Título da revista:', titleController),
      _buildTextField('Editora:', publisherController),
      _buildTextField('Sinopse:', summaryController),
    ];
  }

  /// Widget auxiliar para gerar campos
  static Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      keyboardType: keyboardType,
    );
  }
}
