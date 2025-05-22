import 'package:apiexemplocall23032025/Library.dart';
import 'package:apiexemplocall23032025/PaperMedia.dart';
import 'package:flutter/material.dart';

class Newspaper extends Papermedia{
  String id;
  DateTime date;

  Newspaper({required String title, required String summary, required String publisher, required Library place,
        required this.id, required this.date}):super(title: title, summary: summary, publisher: publisher, place: place);

  Widget itensInformation(BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        Text("$title", style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text("Data de publicação: ${date.toLocal().toString().split(' ')[0]}"),
        Text("Editora: $publisher"),
        Text("Sinopse: $summary"),
      ]
    );
  }

  static List<Widget> itensRegister(BuildContext context, TextEditingController _titleController, TextEditingController _summaryController,
                              TextEditingController _publisherController, TextEditingController _dateController){
      return <Widget>[
        TextField(
        decoration: const InputDecoration(labelText: 'Título do livro:'),
        controller: _titleController,
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Data de publicação:'),
          controller: _dateController,
          readOnly: true,
        ),
        TextField(
        decoration: const InputDecoration(labelText: 'Sinopse:'),
        controller: _summaryController,
        )
      ];
  }
}