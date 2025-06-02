import 'package:apiexemplocall23032025/Standardizer.dart';
import 'package:flutter/material.dart';
import 'general_drawer.dart';
import 'Book.dart';
import 'Library.dart';
import 'Magazine.dart';
import 'Comic.dart';
import 'Newspaper.dart';
import 'InteractionsAPI.dart';
import 'MockDataProvider.dart';

class ListarItens extends StatefulWidget {
  const ListarItens({super.key});

  @override
  State<ListarItens> createState() => _ListarItensPageState();
}

class _ListarItensPageState extends State<ListarItens> {
  // Listas pré-existentes
  List<Library> existingLibraries = [];
  List<Comic> existingComics = [];
  List<Book> existingBooks = [];
  List<Magazine> existingMagazines = [];
  List<Newspaper> existingNewsPapers = [];

  
  Standardizer? itemelecionado;
  String? temaSelecionado;
  bool itemProcurado = false;
  bool filtroAtivo = false;

  final Map<String, double> alturaItens = {
    'Livros': 136,
    'Quadrinhos': 136,
    'Revistas': 96,
    'Jornais': 116,
    'Bibliotecas': 76,
  };

  //Listar Bibliotecas
  Future<void> listLibraries() async{
    List<Library> placeholderLibrary = await Interactionsapi.getLibraries();
    try {
      placeholderLibrary = await Interactionsapi.getLibraries();
      placeholderLibrary.forEach((teste) => print(teste.cep + teste.id + teste.name));
      setState(() {
      existingLibraries = placeholderLibrary;
      });
    } catch (e, stack) {
      print("Erro ao chamar getLibraries: $e");
      print(stack);
      return;
    }
  }

  //Listar Bibliotecas
  Future<void> listComics() async{
    List<Comic> placeholderComics = await Interactionsapi.getComic();
    setState(() {
      existingComics = placeholderComics;
    });
  }

  //Listar Bibliotecas
  Future<void> listBooks() async{
    List<Book> placeholderBooks = await Interactionsapi.getBook();
    setState(() {
      existingBooks = placeholderBooks;
    });
  }

  //Listar Bibliotecas
  Future<void> listMagazines() async{
    List<Magazine> placeholderMagazines = await Interactionsapi.getMagazine();
    setState(() {
      existingMagazines = placeholderMagazines;
    });
  }

  //Listar Bibliotecas
  Future<void> listNewspaper() async{
    List<Newspaper> placeholderNewspaper = await Interactionsapi.getNewsPaper();
    setState(() {
      existingNewsPapers = placeholderNewspaper;
    });
  }

@override
void initState() {
  super.initState();

  final mock = MockDataProvider();

  existingBooks = mock.generateBooks(5);
  existingComics = mock.generateComics(5);
  existingMagazines = mock.generateMagazines(5);
  existingNewsPapers = mock.generateNewspapers(5);
  listLibraries();
}


  Color corPorTipo(String? tipo) {
    switch (tipo) {
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

  Widget informacoesDoItem(Standardizer? item) {
    if(item == null){
        return const Text("Item não encontrado");
    }
    return item.itemInformation(context);
  }

  Widget gerarListaDeItens(String? tipo, List<Standardizer> items) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              itemProcurado = true;
              itemelecionado = items[index];
            });
          },
          child: SizedBox(
            height: alturaItens[tipo] ?? 100,
            child: Container(
              color: corPorTipo(tipo),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: informacoesDoItem(items[index]),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

Widget buildFilteredList(String? temaSelecionado) {
  switch (temaSelecionado) {
    case 'Livros':
      return gerarListaDeItens('Livros', existingBooks);
    case 'Quadrinhos':
      return gerarListaDeItens('Quadrinhos', existingComics);
    case 'Revistas':
      return gerarListaDeItens('Revistas', existingMagazines);
    case 'Jornais':
      return gerarListaDeItens('Jornais', existingNewsPapers);
    case 'Bibliotecas':
      return gerarListaDeItens('Bibliotecas', existingLibraries);
    default:
      return const Text('Nenhum item encontrado');
  }
}

  Widget adicionarBiblioteca(Library biblioteca) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          biblioteca.getName(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text("CEP: ${biblioteca.getCep()}"),
            const Spacer(),
            IconButton(
              onPressed: () {
                biblioteca.addInLibrary(context);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Busca de Itens')),
      drawer: const AppDrawer(),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black.withOpacity(0.05),
        child: Material(
          color: Colors.white,
          elevation: 8,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Nome:',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                itemProcurado = true;
                              });
                            },
                            icon: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        value: temaSelecionado,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Escolha o tipo',
                        ),
                        items: [
                          'Bibliotecas',
                          'Livros',
                          'Quadrinhos',
                          'Revistas',
                          'Jornais'
                        ].map((tipo) {
                          return DropdownMenuItem(
                            value: tipo,
                            child: Text(tipo),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            temaSelecionado = value;
                            filtroAtivo = true;
                            itemProcurado = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: 
                    Row( // listar itens em biblioteca ou bibliotecas que tem itens
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(itemProcurado)
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (itemelecionado is Library) ...[
                                adicionarBiblioteca(itemelecionado as Library),
                              ] else if ([
                                'Livros',
                                'Quadrinhos',
                                'Revistas',
                                'Jornais'
                              ].contains(temaSelecionado)) ...[
                                informacoesDoItem(itemelecionado),
                              ] else ...[
                                const Text('Nenhum item encontrado')
                              ],
                              const SizedBox(height: 8),
                              Expanded( //listar dos temas
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      if (temaSelecionado == 'Bibliotecas') ...[
                                        gerarListaDeItens('Livros', existingBooks),
                                        gerarListaDeItens('Quadrinhos', existingComics),
                                        gerarListaDeItens('Revistas', existingMagazines),
                                        gerarListaDeItens('Jornais', existingNewsPapers),
                                      ] else if ([
                                        'Livros',
                                        'Quadrinhos',
                                        'Revistas',
                                        'Jornais'
                                      ].contains(temaSelecionado)) ...[
                                        gerarListaDeItens('Bibliotecas', existingLibraries),
                                      ] else ...[
                                        const Text('Nenhum item encontrado')
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const Spacer(),
                      if (filtroAtivo)
                        Expanded( //listar do filtro
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                buildFilteredList(temaSelecionado),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
