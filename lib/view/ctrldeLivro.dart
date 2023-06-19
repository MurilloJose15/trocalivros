import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/model/book.dart';
import '/view/customMaterialBanner.dart';

class CtrlLivro extends GetxController {
  File? file;

  Future<FilePickerResult?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      update();
      return result;
    }
    if (result == null) {
      print('Nenhum arquivo selecionado');
    }
    return result;
  }

  Future<String> uploadFile(file) async {
    String downloadURL = '';
    if (file == null) {
      return 'Arquivo está vazio!';
    }

    try {
      var storageReference = FirebaseStorage.instance
          .ref()
          .child('capasLivros/${file!.files.first.name}');

      await storageReference.putData(file!.files.first.bytes);

      downloadURL = await storageReference.getDownloadURL();
    } catch (e) {
      print('Erro ao fazer upload do arquivo: $e');
    }
    return downloadURL;
  }

  Future<void> salvarLivro(context, livro) async {
    if (livro == null) {
      return;
    }

    CollectionReference livros =
      FirebaseFirestore.instance.collection('livros');

    try {
      await livros.add(livro!.toMap());
      customMaterialBanner(
          context, 'Livro Cadastrado com Sucesso', Colors.green);
    } catch (e) {
      print('Erro ao adicionar livro: $e');
    }
  }

  Future<List<Livro>> listarLivros({required String email}) async {
    final db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db
        .collection('livros')
        .where('emailDono', isNotEqualTo: email)
        .where('emprestimo', isEqualTo: 'sim')
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        if (data != null) {
          return Livro.fromJson(data as Map<String, dynamic>, doc.id);
        } else {
          throw Exception('Data is null');
        }
      }).toList();
    } else {
      return [];
    }
  }

  Future<List<Livro>> listarmeusLivros({required String email}) async {
    final db = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot = await db
        .collection('livros')
        .where('emailDono', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        if (data != null) {
          return Livro.fromJson(data as Map<String, dynamic>, doc.id);
        } else {
          throw Exception('Data is null');
        }
      }).toList();
    }

    return [];
  }
}
