import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'customMaterialBanner.dart';

class CtrlUsuario extends GetxController {
  Rx<User?> _user = Rx<User?>(null);

  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  Future<void> salvarUsuario(context, usuario) async {
    if (usuario == null) {
      return;
    }

    CollectionReference usuarios =
    FirebaseFirestore.instance.collection('usuarios');

    try {
      await usuarios.add(usuario!.toMap());
      customMaterialBanner(
          context, 'Usuario Cadastrado com Sucesso', Colors.green);
    } catch (e) {
      print('Erro ao adicionar usuario: $e');
    }
  }
}
