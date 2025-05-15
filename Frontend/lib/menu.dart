import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void menu() => runApp(MyApp());

class Classificacoes {
  final String rating;
  final String film;
  final String note;

  Classificacoes({
    required this.rating,
    required this.film,
    required this.note,
  });

  factory Classificacoes.fromJson(Map<String, dynamic> json) {
    return Classificacoes(
      rating: json['rating'].toString(),
      film: json['film'],
      note: json['note'],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CadastroScreen(),
    );
  }
}

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _notaController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();

  bool texto1 = false;
  bool texto2 = false;
  bool texto3 = false;

  String? _character;

  final url = Uri.parse('http://localhost:8081/projeto/api/v1/review');

  Future<void> enviarParaAPI(double valor, String nome, String comentario) async {
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'film': nome, 'rating': valor, 'note': comentario}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Enviado com sucesso!');
      } else {
        print('Erro ao enviar: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  /// 🔽 Nova versão: retorna uma lista de classificações
  Future<List<Classificacoes>> listarDados() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List respostaJson = json.decode(response.body);
        return respostaJson.map((data) => Classificacoes.fromJson(data)).toList();
      } else {
        print('Erro ao buscar dados: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Erro: $e');
      return [];
    }
  }

  /// 🔽 Mostra os dados num AlertDialog
  Future<void> mostrarClassificacoes() async {
    List<Classificacoes> classificacoes = await listarDados();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Classificações"),
        content: SizedBox(
          width: double.maxFinite,
          child: classificacoes.isEmpty
              ? Text('Nenhuma classificação encontrada.')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: classificacoes.length,
                  itemBuilder: (context, index) {
                    final c = classificacoes[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("🎬 Filme: ${c.film}", style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("⭐ Nota: ${c.rating}"),
                          Text("💬 Comentário: ${c.note}"),
                          Divider(),
                        ],
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Fechar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              title: const Text('Godzilla II'),
              leading: Radio<String>(
                value: "Godzilla II",
                groupValue: _character,
                onChanged: (String? value) {
                  setState(() {
                    _character = value;
                    texto1 = true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Robô Selvagem'),
              leading: Radio<String>(
                value: "Robo Selvagem",
                groupValue: _character,
                onChanged: (String? value) {
                  setState(() {
                    _character = value;
                    texto1 = true;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _notaController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (String value) {
                setState(() {
                  if (value.isNotEmpty) {
                    final texto = value.replaceAll(',', '.');
                    final nota = double.tryParse(texto);
                    texto2 = nota != null && nota >= 0 && nota <= 5;
                  } else {
                    texto2 = false;
                  }
                });
              },
              decoration: InputDecoration(labelText: 'Nota (entre 0-5)'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _comentarioController,
              onChanged: (String value) {
                setState(() {
                  texto3 = value.isNotEmpty;
                });
              },
              decoration: InputDecoration(labelText: 'Comentários:'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: texto1 && texto2 && texto3
                  ? () {
                      final texto = _notaController.text.replaceAll(',', '.');
                      final nota = double.parse(texto);
                      enviarParaAPI(nota, _character!, _comentarioController.text);

                      final snackbar = SnackBar(
                        content: const Text('Nota e comentário adicionados :)'),
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  : null,
              child: Text('Cadastrar'),
            ),
            ElevatedButton(
              onPressed: mostrarClassificacoes,
              child: Text('Listar classificações'),
            ),
          ],
        ),
      ),
    );
  }
}
