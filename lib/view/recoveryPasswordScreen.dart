import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'customMaterialBanner.dart';

class RecoveryPassScreen extends StatefulWidget {
  const RecoveryPassScreen({Key? key}) : super(key: key);

  @override
  State<RecoveryPassScreen> createState() => _RecoveryPassScreenState();
}

class _RecoveryPassScreenState extends State<RecoveryPassScreen> {
  TextEditingController _controladorEmail = TextEditingController();

  Future<void> esqueceuSenhaFirebase(context, String emailAddress) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
    customMaterialBanner(context, 'E-mail de Recuperação Enviado!', Colors.green);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controladorEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 15, 32, 10),
        child: Column(
          children: [
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
            ElevatedButton(
                onPressed: () {
                  esqueceuSenhaFirebase(context, _controladorEmail.text);
                },
                child: Text('Recuperar Senha'))
          ],
        ),
      ),
    );
  }
}
