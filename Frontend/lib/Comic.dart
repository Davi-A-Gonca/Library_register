import 'package:apiexemplocall23032025/Library.dart';
import 'package:apiexemplocall23032025/PaperMedia.dart';
import 'package:apiexemplocall23032025/Standardizer.dart';
import 'package:flutter/material.dart';

class Comic extends Papermedia implements Standardizer{
  final String id;
  final String author;
  final String artist;

  Comic({
    required String title,
    required String summary,
    required String publisher,
    required Library place,
    required this.id,
    required this.author,
    required this.artist,
  }) : super(
          title: title,
          summary: summary,
          publisher: publisher,
          place: place,
        );

  /// Widget para exibir informações do quadrinho
  Widget itemInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text('Autor(a): $author'),
        Text('Artista: $artist'),
        Text('Editora: $publisher'),
        Text('Sinopse: $summary'),
      ],
    );
  }

  /// Campos para cadastro de quadrinho
  static List<Widget> itemRegister(
    BuildContext context, //Talvez esse não precise, mas fiquei com medo de alguma coisa dar errado então deixei aqui
    TextEditingController titleController,
    TextEditingController summaryController,
    TextEditingController publisherController,
    TextEditingController authorController,
    TextEditingController artistController,
  ) {
    return [
      _buildTextField('Título do quadrinho:', titleController),
      _buildTextField('Escritor(a):', authorController),
      _buildTextField('Artista:', artistController),
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
