import 'package:flutter/material.dart';
import 'LibraryRegister.dart';
import 'main.dart';
import 'listarItens.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Listar Itens'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListarItens()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Cadastrar Item'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LibraryRegisterApp()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginApp()),
                (Route<dynamic> route) => false, // Remove todas as telas anteriores
              );
            },
          ),
        ],
      ),
    );
  }
}
