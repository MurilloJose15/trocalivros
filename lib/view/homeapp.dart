import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:trocalivros/view/ctrldeLivro.dart';
import 'custom_drawer.dart';
import 'package:get/get.dart';

class HomeScreenApp extends StatefulWidget {
  const HomeScreenApp({Key? key}) : super(key: key);

  @override
  State<HomeScreenApp> createState() => _HomeScreenAppState();
}

class _HomeScreenAppState extends State<HomeScreenApp>{

  final CtrlLivro ctrlLivro = Get.put(CtrlLivro());

  Future<void> deslogarFirebase() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Troca Livros'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.search),
          ),
          GestureDetector(onTap: deslogarFirebase, child: Icon(Icons.logout)),
        ],
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 200,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                onPressed: () {
                  Get.toNamed('/tLivros');
                },
                child: Text('Todos os Livros'),
              ),
            )
          ],
        ),
      )
    );
  }
}

