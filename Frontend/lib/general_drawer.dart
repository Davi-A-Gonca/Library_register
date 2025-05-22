import 'package:flutter/material.dart';
import 'cadastrarItens.dart';
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
              listarItens();
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Cadastrar Item'),
            onTap: () {
              cadastrarItens();
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              main();
            },
          ),
        ],
      ),
    );
  }
}
