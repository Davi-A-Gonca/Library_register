import 'package:apiexemplocall23032025/Library.dart';
import 'package:apiexemplocall23032025/PaperMedia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Book extends Papermedia {
  final String id;
  final String author;
  final int nPages;

  Book({
    required String title,
    required String summary,
    required String publisher,
    required Library place,
    required this.id,
    required this.author,
    required this.nPages,
  }) : super(
          title: title,
          summary: summary,
          publisher: publisher,
          place: place,
        );

  /// Mostra informações do livro em formato de Widget
  Widget itemInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('Autor: $author'),
        Text('Sinopse: $summary'),
        Text('Editora: $publisher'),
        Text('Número de páginas: $nPages'),
      ],
    );
  }

  /// Retorna os campos de cadastro de livro
  static List<Widget> itemRegister(
    BuildContext context, //Talvez esse não precise, mas fiquei com medo de alguma coisa dar errado então deixei aqui
    TextEditingController titleController,
    TextEditingController summaryController,
    TextEditingController publisherController,
    TextEditingController authorController,
    TextEditingController nPagesController
  ) {
    return [
      _buildTextField('Título do livro:', titleController),
      _buildTextField('Autor(a):', authorController),
      _buildTextField('Editora:', publisherController),
      _buildTextField('Sinopse:', summaryController),
      _buildTextField(
        'Número de páginas:',
        nPagesController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    ];
  }

  /// Widget auxiliar para evitar repetição dos TextFields
  static Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}
