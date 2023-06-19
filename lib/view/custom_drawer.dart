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
  final CtrlUsuario _ctrlUsuario = Get.put(CtrlUsuario());

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
            accountName: Text(_ctrlUsuario.user?.displayName ?? ''),
            accountEmail: Text(_ctrlUsuario.user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _ctrlUsuario.user?.email?.isNotEmpty == true
                          ? _ctrlUsuario.user!.email![0]
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
            leading: Icon(Icons.bookmarks),
            title: Text('Livros Disponíveis'),
            onTap: () {
              Get.toNamed('/tLivros');
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
            title: Text('Cadastrar Meu Livro Lido'),
            onTap: () {
              Get.toNamed('/CadLivro');
            },
          ),

          ListTile(
            leading: Icon(Icons.list),
            title: Text('Listar Meus Livros Lidos'),
            onTap: () {
              Get.toNamed('/listBooks');
            },
          ),
        ],
      ),
    );
  }
}
