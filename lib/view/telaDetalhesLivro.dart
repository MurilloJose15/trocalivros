import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trocalivros/view/ctrlDetalheLivros.dart';

class TelaDetalhesLivro extends StatelessWidget {

  Future<void> atualizarEmpLivro(livroId, operacao) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot = await db
        .collection('livros')
        .where('isbn', isEqualTo: livroId)
        .get();
    final DocumentSnapshot livroSnapshot = querySnapshot.docs.first;
    final DocumentReference livroRef = livroSnapshot.reference;

    livroRef.update({'emprestimo': '${operacao}'});
    Get.snackbar('Operação realizada com sucesso',
        '');
  }

  @override
  Widget build(BuildContext context) {
    final CtrlDetalheLivros controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Livro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.network(controller.livro.capa),
            ),
            SizedBox(height: 16),

            SizedBox(height: 8),
            Text(
              'ISBN:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              controller.livro.isbn,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Sinopse:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              controller.livro.sinopse,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {
                  atualizarEmpLivro(controller.livro.isbn, 'sim');

                }, child: Text('Emprestar')),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () {
                      atualizarEmpLivro(controller.livro.isbn, 'nao');

                    }, child: Text('Retirar do Empréstimo')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
