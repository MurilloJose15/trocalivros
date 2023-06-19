import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:trocalivros/model/book.dart';
import 'package:validatorless/validatorless.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  bool _isObscure = true;
  final  _controladorEmail = TextEditingController();
  final  _controladorSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();



  Future<void> logarUsuarioFirebase() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _controladorEmail.text, password: _controladorSenha.text);

      Navigator.of(context)
          .pushNamedAndRemoveUntil('/signed', (Route<dynamic> route) => false);
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Email ou senha incorretos!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    var formValid = _formKey.currentState?.validate() ?? false;
    if(formValid){

    }
  }

  // Future<SocialNetworkModel> googleLogin() async {
  //   final googleSignIn = GoogleSignIn();
  //
  //   if(await googleSignIn.isSignedIn()) {
  //     await googleSignIn.disconnect();
  //   }
  //
  //   final googleUser = await googleSignIn.signIn();
  //   final googleAuth = await googleUser?.authentication;
  //
  //   if(googleAuth!= null && googleUser != null) {
  //     return SocialNetworkModel(
  //         id: googleAuth.idToken ?? '',
  //         name: googleUser.displayName ?? '',
  //         email: googleUser.email,
  //         type: 'Google',
  //         avatar: googleUser.photoUrl,
  //         accessToken: googleAuth.accessToken ?? '',
  //     );
  //   }else {
  //     throw AlertDialog(content: Text('Erro ao tentar logar com o Google'));
  //   }
  // }

  Future<void> logarGoogle() async {
    final GoogleSignIn googleSignIn = await GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;
    print(googleAuth?.idToken); // should not be null or empty
    print(googleAuth?.accessToken); // should not be null or empty

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential authResult = await FirebaseAuth.instance
        .signInWithCredential(credential);
    final User? user = authResult.user;

    //customMaterialBanner(context, 'Logado com sucesso!', Colors.green);
    if (user != null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(
          '/signed', (Route<dynamic> route) => false);
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60),
            child: Text(
              'Troca Livros',
              style: TextStyle(fontSize: 40.0,),
            ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _controladorEmail,
              decoration: const InputDecoration(
                  label: Text('E-mail'),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email)),
              validator: Validatorless.multiple([
                Validatorless.required('Email é Obrigatório!'),
                Validatorless.email('Email inválido!')
              ]),
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
                controller: _controladorSenha,
                obscureText: _isObscure,
                validator: Validatorless.required('Senha obrigatória'),
                decoration: InputDecoration(
                  hintText: 'Senha',
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  prefixIcon: Icon(Icons.password),
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
            onPressed: logarUsuarioFirebase, child: Text('Logar'),),
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
          SizedBox(height: 15),
          const _OrSeparator(),
          SizedBox(height: 15),
          Column(
            children: [
              GestureDetector(
                onTap: logarGoogle,
                child: Container(

                    height: 40,
                    child: Image.asset('images/google.png'),
                ),
              ),
              SizedBox(height: 5,),
              Text('Logar com o Google',
                  style: TextStyle(color: Colors.blue))
            ],
          ),
        ],
      ),
    );
  }
}

class _OrSeparator extends StatelessWidget {
  const _OrSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          thickness: 1,
          color: Colors.blue,
        ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'OU',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue
            ),),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

