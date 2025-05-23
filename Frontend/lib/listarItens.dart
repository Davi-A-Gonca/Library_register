import 'package:flutter/material.dart';
import 'general_drawer.dart';
import 'Book.dart';
import 'Library.dart';
import 'Magazine.dart';
import 'Comic.dart';
import 'Newspaper.dart';

class ListarItens extends StatefulWidget {
  const ListarItens({super.key});

  @override
  State<ListarItens> createState() => _ListarItensPageState();
}

class _ListarItensPageState extends State<ListarItens> {
  String? temaSelecionado;
  bool itemProcurado = false;
  bool filtroAtivo = false;

  Library bibliotecaExemplo = Library(id: "4321", name: "Minha Biblioteca", cep: "14806-188");
  late Book livroExemplo = Book(
    title: "Livro maneiro",
    summary: "Livro exemplo",
    publisher: "Editora Exemplo",
    place: bibliotecaExemplo,
    id: "1234",
    author: "Autor Desconhecido",
    nPages: 100,
  );
  late Magazine revistaExemplo = Magazine(
    title: "Revista Legal",
    summary: "Resumo da revista",
    publisher: "Editora A",
    place: bibliotecaExemplo,
    id: "5678",
  );
  late Comic quadrinhoExemplo = Comic(
    title: "Quadrinho Show",
    summary: "Quadrinho muito bacana",
    publisher: "HQ Editora",
    place: bibliotecaExemplo,
    id: "9101",
    author: "Desenhista X",
    artist: "Artista Y",
  );
  late Newspaper jornalExemplo = Newspaper(
    title: "Jornal Diário",
    summary: "Notícias do dia",
    publisher: "Editora Notícias",
    place: bibliotecaExemplo,
    id: "1121",
    date: DateTime(2024, 12, 25),
  );

  final Map<String, double> alturaItens = {
    'Livros': 136,
    'Quadrinhos': 136,
    'Revistas': 96,
    'Jornais': 116,
    'Bibliotecas': 76,
  };

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

  Widget informacoesDoItem(String? tipo) {
    switch (tipo) {
      case 'Livros':
        return livroExemplo.itemInformation(context);
      case 'Revistas':
        return revistaExemplo.itemInformation(context);
      case 'Quadrinhos':
        return quadrinhoExemplo.itemInformation(context);
      case 'Jornais':
        return jornalExemplo.itemInformation(context);
      case 'Bibliotecas':
        return bibliotecaExemplo.itemInformation(context);
      default:
        return const Text("Item não encontrado");
    }
  }

  Widget gerarListaDeItens(String? tipo, int quantidade) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      itemCount: quantidade,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              itemProcurado = true;
            });
          },
          child: SizedBox(
            height: alturaItens[tipo] ?? 100,
            child: Container(
              color: corPorTipo(tipo),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: informacoesDoItem(tipo),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
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
                    Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(itemProcurado)
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (temaSelecionado == 'Bibliotecas') ...[
                                adicionarBiblioteca(bibliotecaExemplo),
                              ] else if ([
                                'Livros',
                                'Quadrinhos',
                                'Revistas',
                                'Jornais'
                              ].contains(temaSelecionado)) ...[
                                informacoesDoItem(temaSelecionado),
                              ] else ...[
                                const Text('Nenhum item encontrado')
                              ],
                              const SizedBox(height: 8),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      if (temaSelecionado == 'Bibliotecas') ...[
                                        gerarListaDeItens('Livros', 3),
                                        gerarListaDeItens('Quadrinhos', 3),
                                        gerarListaDeItens('Revistas', 3),
                                        gerarListaDeItens('Jornais', 3),
                                      ] else if ([
                                        'Livros',
                                        'Quadrinhos',
                                        'Revistas',
                                        'Jornais'
                                      ].contains(temaSelecionado)) ...[
                                        gerarListaDeItens('Bibliotecas', 3),
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
                        Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                gerarListaDeItens(temaSelecionado, 5),
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
