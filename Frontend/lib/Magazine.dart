import 'package:apiexemplocall23032025/Library.dart';
import 'package:apiexemplocall23032025/PaperMedia.dart';
import 'package:flutter/material.dart';

class Magazine extends Papermedia{
  String id;

  Magazine({required String title, required String summary, required String publisher, required Library place,
        required this.id}):super(title: title, summary: summary, publisher: publisher, place: place);

  Widget itensInformation(BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        Text("$title", style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text("Sinopse: $summary"),
        Text("Editora: $publisher"),
      ]
    );
  }

  static List<Widget> itensRegister(BuildContext context, TextEditingController _titleController, TextEditingController _summaryController,
                              TextEditingController _publisherController){
      return <Widget>[
        TextField(
        decoration: const InputDecoration(labelText: 'Título do livro:'),
        controller: _titleController,
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