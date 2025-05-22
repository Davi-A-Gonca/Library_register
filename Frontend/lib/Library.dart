import 'package:flutter/material.dart';

class Library {
    String id;
    String name;
    String cep;

    Library({required this.id, required this.name, required this.cep});

    Widget itensInformation(BuildContext context){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text("$name", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text("Cep: $cep"),
        ]
        );
    }

    static List<Widget> itensRegister(BuildContext context, TextEditingController _nameController, TextEditingController _cepController){
        return <Widget>[
            TextField(
            decoration: const InputDecoration(labelText: 'Nome da biblioteca:'),
            controller: _nameController,
            ),
            TextField(
            decoration: const InputDecoration(labelText: 'CEP:'),
            controller: _cepController,
            )
        ];
    }

}