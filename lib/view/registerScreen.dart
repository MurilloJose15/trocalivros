import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';


import 'customMaterialBanner.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controladorEmail = TextEditingController();
  TextEditingController _controladorSenha = TextEditingController();


  Future<void> cadastrarUsuarioFirebase(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _controladorEmail.text, password: _controladorSenha.text,);
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
    var formValid = _formKey.currentState?.validate() ?? false;
    if(formValid){

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
    return Form(
      key: _formKey,
      child: Scaffold(
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
              TextFormField(
                controller: _controladorEmail,
                validator: Validatorless.multiple([
                  Validatorless.required('Email é Obrigatório!'),
                  Validatorless.email('Email inválido!')
                ]),
                decoration: InputDecoration(
                  hintText: 'E-mail',
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _controladorSenha,
                validator: Validatorless.multiple([
                  Validatorless.required('Senha obrigatória'),
                  Validatorless.min(6, 'A senha deve conter pelo menos 6 caracteres'),
                ]),
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
                    await cadastrarUsuarioFirebase(context);
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: Text('Registrar'))
            ],
          ),
        ),
      ),
    );
  }
}