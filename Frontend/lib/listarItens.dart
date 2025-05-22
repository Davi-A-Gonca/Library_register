import 'package:apiexemplocall23032025/Book.dart';
import 'package:apiexemplocall23032025/Library.dart';
import 'package:apiexemplocall23032025/Magazine.dart';
import 'package:apiexemplocall23032025/Comic.dart';
import 'package:apiexemplocall23032025/Newspaper.dart';
import 'package:flutter/material.dart';
import 'general_drawer.dart';

void listarItens() => runApp(const OverflowBarExampleApp());

class OverflowBarExampleApp extends StatelessWidget {
  const OverflowBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Busca de Itens')),
        drawer: const AppDrawer(),
        body: const Center(child: OverflowBarExample()),
      ),
    );
  }
}

class OverflowBarExample extends StatefulWidget {
  const OverflowBarExample({super.key});

  @override
  State<OverflowBarExample> createState() => _OverflowBarExampleState();
}

class _OverflowBarExampleState extends State<OverflowBarExample> {
  
  Color getColorForType(String? typeOfIten) {
    switch (typeOfIten) {
      case 'Livros':
        return Colors.blue.shade50;
      case 'Quadrinhos':
        return Colors.purple.shade50;
      case 'Revistas':
        return Colors.orange.shade50;
      case 'Jornais':
        return Colors.green.shade50;
      case 'Bibliotecas':
        return Colors.red.shade50;
      default:
        return Colors.grey.shade300;
    }
  }
  
  Widget intensInformation(String? typeOfIten){
    switch(typeOfIten){
      case 'Livros': return teste.itensInformation(context);
      case 'Revistas': return testeRev.itensInformation(context);
      case 'Quadrinhos': return testeComic.itensInformation(context);
      case 'Jornais': return testeNP.itensInformation(context);
      case 'Bibliotecas': return essa.itensInformation(context);
      default:
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text("Exemplo", style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text("Autor: Exemplo"),
            Text("Categoria: Exemplo"),
            Text("Número de páginas: X"),
          ]
        );
    }
  }

/*  List<Widget> itemFound(String? typeOfIten, int times){
      switch(typeOfIten){
        case 'Livros':
          return <Widget> [
            for(int i = 0; i < times; i ++){
              teste.itensInformation(context);
            }
          ];
        case 'Revistas': return testeRev.itensInformation(context);
        case 'Quadrinhos': return testeComic.itensInformation(context);
        case 'Jornais': return testeNP.itensInformation(context);
        case 'Bibliotecas': return essa.itensInformation(context);
        default:
          return <Widget> [Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text("Exemplo", style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text("Autor: Exemplo"),
              Text("Categoria: Exemplo"),
              Text("Número de páginas: X"),
            ]
          ),
          ];
    }
  }*/

  Widget itensToFind(String? typeOfIten, int times){
    return Column(
crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: times,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  itemProcurado = true;
                });
              },
              child: SizedBox(
              height: heightSizedBox[typeOfIten],
              child: Container(
                color: getColorForType(typeOfIten),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    intensInformation(typeOfIten),
                  ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ],
    );
  }
  
  String? temaSelecionado;
  bool itemProcurado = false;
  bool buscaporTipo = false;
  Library essa = Library(id: "4321", name: "name", cep: "14806-188");
  late Book teste = Book(title: "Crainaça", summary: "Escrevi errado kk", publisher: "Esse mesmo", place: essa, id: "1234", author: "Eu", nPages: 4);
  late Magazine testeRev = Magazine(title: "Crainaça", summary: "Escrevi errado kk", publisher: "Esse mesmo", place: essa, id: "1234");
  late Comic testeComic = Comic(title: "Crainaça", summary: "Escrevi errado kk", publisher: "Esse mesmo", place: essa, id: "1234", author: "Eu", artist: "Mare :)");
  late Newspaper testeNP = Newspaper(title: "Crainaça", summary: "Escrevi errado kk", publisher: "Esse mesmo", place: essa, id: "1234", date: DateTime(2020, 12, 30));
  Map<String, double> heightSizedBox = {'Livros': 120, 'Quadrinhos': 120, 'Revistas': 80, 'Jornais': 100, 'Bibliotecas': 60};


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.black.withOpacity(0.15),
      child: Material(
        color: Colors.white,
        elevation: 24,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Nome:',
                        suffixIcon: IconButton(
                          onPressed: buscaporTipo ? () {
                            setState((){
                              itemProcurado = true;
                            });
                          } : null,
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Escolha o que pesquisar'),
                        DropdownButton<String>(
                          value: temaSelecionado,
                          isExpanded: true,
                          hint: const Text('Selecione um tema'),
                          items: <String>['Bibliotecas', 'Livros', 'Quadrinhos', 'Revistas', 'Jornais']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              temaSelecionado = newValue;
                              buscaporTipo = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(itemProcurado)
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            intensInformation(temaSelecionado),
                            const SizedBox(height: 8),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children:[
                                    itensToFind(temaSelecionado, 3),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Spacer(),
                    if(buscaporTipo)
                      Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          child: Column(
                            children:[
                              itensToFind('Livros', 3),
                              itensToFind('Quadrinhos', 3),
                              itensToFind('Revistas', 3),
                              itensToFind('Jornais', 3),
                              itensToFind('Bibliotecas', 3),
                              itensToFind('Nada', 3),
                            ]
                          )
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
