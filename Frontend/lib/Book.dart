import 'package:apiexemplocall23032025/Library.dart';
import 'package:apiexemplocall23032025/PaperMedia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Book extends Papermedia{
  String id;
  String author;
  int nPages;

  Book({required String title, required String summary, required String publisher, required Library place,
        required this.id, required this.author, required this.nPages}):super(title: title, summary: summary, publisher: publisher, place: place);

  Widget itensInformation(BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        Text("$title", style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text("Autor: $author"),
        Text("Sinopse: $summary"),
        Text("Editora: $publisher"),
        Text("Número de páginas: $nPages"),
      ]
    );
  }

  static List<Widget> itensRegister(BuildContext context, TextEditingController _titleController, TextEditingController _summaryController,
                              TextEditingController _publisherController, TextEditingController _authorController, TextEditingController _nPagesController){
      return <Widget> [
        TextField(
        decoration: const InputDecoration(labelText: 'Título do livro:'),
        controller: _titleController,
        ),
        TextField(
        decoration: const InputDecoration(labelText: 'Autor/a:'),
        controller: _authorController,
        ),
        TextField(
        decoration: const InputDecoration(labelText: 'Editora:'),
        controller: _publisherController,
        ),
        TextField(
        decoration: const InputDecoration(labelText: 'Sinopse:'),
        controller: _summaryController,
        ),
        TextField(
        decoration: const InputDecoration(labelText: 'Número de páginas:'),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: _nPagesController,
        )
         ];
  }

}