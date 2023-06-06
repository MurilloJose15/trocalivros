import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:validatorless/validatorless.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> logarUsuarioFirebase() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      Navigator.of(context)
          .pushNamedAndRemoveUntil('/signed', (Route<dynamic> route) => false);
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Email ou senha incorretos!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Text(
              'Troca Livros',
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                controller: _emailController,
                validator: Validatorless.multiple([
                  Validatorless.required('Email is required'),
                  Validatorless.email('Invalid email'),
                ]),
                decoration: InputDecoration(
                  hintText: 'E-mail',
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextFormField(
                controller: _passwordController,
                obscureText: _isObscure,
                validator: Validatorless.multiple([
                  Validatorless.required('A senha é obrigatória'),
                  Validatorless.min(8, 'A senha deve ter pelo menos 8 caracteres'),
                ]),
                decoration: InputDecoration(
                  hintText: 'Senha',
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  suffixIcon: GestureDetector(
                    child: Icon(Icons.remove_red_eye),
                    onTap: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Get.toNamed('/recoveryPass');
            },
            child: Text(
              'Esqueceu a senha?',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: logarUsuarioFirebase, child: Text('Logar'),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Get.toNamed('/register');
            },
            child: Text(
              'Não tem conta? Registre-se agora',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
