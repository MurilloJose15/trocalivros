import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'customMaterialBanner.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _controladorEmail = TextEditingController();
  TextEditingController _controladorSenha = TextEditingController();


  Future<void> cadastrarUsuarioFirebase(
      context, String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      customMaterialBanner(
          context, 'Conta Cadastrada com Sucesso!', Colors.green);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.code);
        customMaterialBanner(context, 'Erro - Senha Fraca!', Colors.red);
      } else if (e.code == 'email-already-in-use') {
        print(e.code);
        customMaterialBanner(context, 'Erro - E-mail em uso!', Colors.red);
      }
    } catch (e) {
      print(e);
      customMaterialBanner(context, 'Erro - Desconhecido', Colors.red);
    }
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controladorEmail.dispose();
    _controladorSenha.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Novo Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controladorEmail,
              decoration: InputDecoration(
                label: Text('E-mail'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controladorSenha,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Senha'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await cadastrarUsuarioFirebase(
                      context, _controladorEmail.text, _controladorSenha.text);
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: Text('Registrar'))
          ],
        ),
      ),
    );
  }
}
