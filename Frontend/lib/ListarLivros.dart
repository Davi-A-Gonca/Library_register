import 'package:flutter/material.dart';

void main() => runApp(const OverflowBarExampleApp());

class OverflowBarExampleApp extends StatelessWidget {
  const OverflowBarExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Busca de Livros')),
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
  String? temaSelecionado;
  bool livroProcurado = false;
  bool livrosPorTema = false;
  final List<int> colorCodes = <int>[600, 600, 600, 600, 600, 600, 600, 600, 600];

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
                          onPressed: () {
                            setState((){
                              livroProcurado = true;
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tema do Livro'),
                        DropdownButton<String>(
                          value: temaSelecionado,
                          isExpanded: true,
                          hint: const Text('Selecione um tema'),
                          items: <String>['Romance', 'Terror', 'Ficção', 'Aventura']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              temaSelecionado = newValue;
                              livrosPorTema = true;
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
                  children: [
                    if(livroProcurado)
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Exemplo", style: Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: 8),
                            const Text("Autor: Exemplo"),
                            const Text("Categoria: Exemplo"),
                            const Text("Número de páginas: X"),
                            const SizedBox(height: 8),
                            Expanded(
                              flex: 2,
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                itemCount: 9,
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 100,
                                    child: Container(
                                      color: Colors.amber[colorCodes[index]],
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Exemplo", style: Theme.of(context).textTheme.headlineSmall),
                                          const SizedBox(height: 8),
                                          const Text("Autor: Exemplo"),
                                          const Text("Categoria: Exemplo"),
                                          const Text("Número de páginas: X"),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) => const Divider(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Spacer(),
                    if(livrosPorTema)
                      Expanded(
                        flex: 2,
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: 9,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  livroProcurado = true;
                                });
                              },
                              child: SizedBox(
                              height: 100,
                              child: Container(
                                color: Colors.amber[colorCodes[index]],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Exemplo", style: Theme.of(context).textTheme.headlineSmall),
                                    const SizedBox(height: 8),
                                    const Text("Autor: Exemplo"),
                                    const Text("Categoria: Exemplo"),
                                    const Text("Número de páginas: X"),
                                    ],
                                  ),
                                ),
                              )
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Cadastro'),
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Continuar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
