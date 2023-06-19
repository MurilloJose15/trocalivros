import 'package:firebase_auth/firebase_auth.dart';
import 'ctrldeUsuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'customMaterialBanner.dart';
import 'custom_drawer.dart';


class UserUpdateScreen extends StatefulWidget {
  @override
  _UserUpdateScreenState createState() => _UserUpdateScreenState();
}

class _UserUpdateScreenState extends State<UserUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  Future<void> atualizarUsuarioAuthFirebase(
      context, String email, String displayName) async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.updateDisplayName(displayName);
      user.updateEmail(email);
      customMaterialBanner(
          context, 'Dados Atualizados com Sucesso!', Colors.green);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrlUsuario = Get.find<CtrlUsuario>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar Perfil'),
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu e-mail';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  atualizarUsuarioAuthFirebase(
                      context, _emailController.text, _nameController.text);
                }
              },
              child: Text('Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
