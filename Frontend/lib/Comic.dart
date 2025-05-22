import 'package:apiexemplocall23032025/Library.dart';
import 'package:apiexemplocall23032025/PaperMedia.dart';
import 'package:flutter/material.dart';

class Comic extends Papermedia{
  String id;
  String author;
  String artist;

  Comic({required String title, required String summary, required String publisher, required Library place,
        required this.id, required this.author, required this.artist}):super(title: title, summary: summary, publisher: publisher, place: place);

  Widget itensInformation(BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        Text("$title", style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text("Autor: $author"),
        Text("Artist: $artist"),
        Text("Editora: $publisher"),
        Text("Sinopse: $summary"),
      ]
    );
  }

  static List<Widget> itensRegister(BuildContext context, TextEditingController _titleController, TextEditingController _summaryController,
                              TextEditingController _publisherController, TextEditingController _authorController, TextEditingController _artistController){
      return <Widget>[
        TextField(
        decoration: const InputDecoration(labelText: 'Título do Quadrinho:'),
        controller: _titleController,
        ),
        TextField(
        decoration: const InputDecoration(labelText: 'Escritor:'),
        controller: _authorController,
        ),
        TextField(
        decoration: const InputDecoration(labelText: 'Artista:'),
        controller: _artistController,
        ),
        TextField(
        decoration: const InputDecoration(labelText: 'Editora:'),
        controller: _publisherController,
        ),
        TextField(
        decoration: const InputDecoration(labelText: 'Sinopse:'),
        controller: _summaryController,
        )
      ];
  }

}