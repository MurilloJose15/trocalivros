import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'custom_drawer.dart';

class HomeAppScreen extends StatefulWidget {
  const HomeAppScreen({Key? key}) : super(key: key);

  @override
  State<HomeAppScreen> createState() => _HomeAppScreenState();
}

class _HomeAppScreenState extends State<HomeAppScreen> {

  Future<void> deslogarFirebase() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
      .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Troca Livros'),
        actions: [
          GestureDetector(onTap: deslogarFirebase, child: Icon(Icons.logout)),
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}
