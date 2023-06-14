import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ctrldeUsuario.dart';



class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final UserController _userController = Get.put(UserController());

  Future<void> deslogarFirebase() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(_userController.user?.displayName ?? ''),
            accountEmail: Text(_userController.user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _userController.user?.email?.isNotEmpty == true
                          ? _userController.user!.email![0]
                          : 'M',
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ],
                )),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Página Inicial'),
            onTap: () {
              Get.toNamed('/signed');
            },
          ),
          ListTile(
            leading: Icon(Icons.update),
            title: Text('Atualizar Perfil do Usuário'),
            onTap: () {
              Get.toNamed('/userUpdate');
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Cadastrar Livro para Ler'),
            onTap: () {
              // Atualize o estado do aplicativo
              // ...
              // Em seguida, feche o drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.done),
            title: Text('Cadastrar Livro Lido'),
            onTap: () {
              // Atualize o estado do aplicativo
              // ...
              // Em seguida, feche o drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Listar Livros Lidos'),
            onTap: () {
              // Atualize o estado do aplicativo
              // ...
              // Em seguida, feche o drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sair'),
            onTap: deslogarFirebase,
          ),
        ],
      ),
    );
  }
}
