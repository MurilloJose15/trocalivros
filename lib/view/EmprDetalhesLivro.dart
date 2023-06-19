import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trocalivros/view/chamarnoZap.dart';
import 'package:trocalivros/view/ctrlDetalheLivros.dart';

class EmprDetalhesLivro extends StatelessWidget {
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
            SizedBox(height: 24),
            Text(
              'ISBN: ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              controller.livro.isbn,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {
                  Get.to(() => ChamarnoZap('+5569984324224'));
                }, child: Text('Solicitar Empréstimo')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
