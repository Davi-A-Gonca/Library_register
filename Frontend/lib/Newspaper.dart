import 'package:apiexemplocall23032025/Library.dart';
import 'package:apiexemplocall23032025/PaperMedia.dart';
import 'package:flutter/material.dart';
import 'Standardizer.dart';

class Newspaper extends Papermedia  implements Standardizer{
  final String id;
  final DateTime date;

  Newspaper({
    required String title,
    required String summary,
    required String publisher,
    required Library place,
    required this.id,
    required this.date,
  }) : super(
          title: title,
          summary: summary,
          publisher: publisher,
          place: place,
        );

  /// Widget que exibe as informações do jornal
  Widget itemInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('Data de publicação: ${_formatDate(date)}'),
        Text('Editora: $publisher'),
        Text('Sinopse: $summary'),
      ],
    );
  }

  /// Função que cria os campos para cadastro de jornais
  static List<Widget> itemRegister(
    BuildContext context, //Talvez esse não precise, mas fiquei com medo de alguma coisa dar errado então deixei aqui
    TextEditingController titleController,
    TextEditingController summaryController,
    TextEditingController publisherController,
    TextEditingController dateController,
  ) {
    return [
      _buildTextField('Título do jornal:', titleController),
      _buildTextField('Editora:', publisherController, readOnly: true),
      _buildTextField('Data de publicação:', dateController, readOnly: true),
      _buildTextField('Sinopse:', summaryController),
    ];
  }

  /// Widget auxiliar para gerar TextFields
  static Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
    );
  }

  /// Formata a data no padrão dd/mm/yyyy
  static String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
           '${date.month.toString().padLeft(2, '0')}/'
           '${date.year}';
  }
}
