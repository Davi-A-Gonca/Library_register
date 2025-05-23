import 'package:apiexemplocall23032025/LibraryRegister.dart';
import 'package:apiexemplocall23032025/listarItens.dart';
import 'package:flutter/material.dart';

// Função principal que executa o app
void main() => runApp(const LoginApp());

// App principal
class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Login/Cadastro'),
          ),
        ),
        body: const Center(
          child: LoginScreen(),
        ),
      ),
    );
  }
}

// Controladores dos campos de texto (nome e senha)
final TextEditingController _nameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

// Tela de Login e Cadastro
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool cadastroAtivo = false;
  String nome = '';
  String senha = '';

  // Lista simples para armazenar usuários (nome e senha)
  final Map<String, String> usuarios = {
    'nome': 'senha',
  };

  // Função para realizar o login
  Future<void> fazerLogin(String nome, String senha) async {
    if (usuarios[nome] == senha) {
      // Login bem-sucedido → Redireciona para a próxima tela
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LibraryRegisterApp()),
      );
    } else {
      // Login falhou → Pergunta se quer cadastrar
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Erro no login'),
          content: const Text('Nome ou senha incorretos.\nDeseja se cadastrar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                fazerCadastro(nome, senha);
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      );
    }
  }

  // Função para realizar o cadastro
  Future<void> fazerCadastro(String nome, String senha) async {
    setState(() {
      usuarios[nome] = senha;
      cadastroAtivo = false;
      _nameController.clear();
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      color: Colors.black.withOpacity(0.15),
      child: Material(
        color: Colors.white,
        elevation: 24,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Campo de nome
                TextField(
                  decoration: const InputDecoration(labelText: 'Nome'),
                  controller: _nameController,
                  onChanged: (value) {
                    setState(() {
                      nome = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                // Campo de senha
                TextField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  controller: _passwordController,
                  onChanged: (value) {
                    setState(() {
                      senha = value;
                    });
                  },
                ),

                const SizedBox(height: 30),

                // Botões de ação
                Row(
                  children: [
                    if (!cadastroAtivo)
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            cadastroAtivo = true;
                          });
                        },
                        child: const Text('Cadastro'),
                      ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () {
                        if (cadastroAtivo) {
                          fazerCadastro(nome, senha);
                        } else {
                          fazerLogin(nome, senha);
                        }
                      },
                      child: const Text('Continuar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
