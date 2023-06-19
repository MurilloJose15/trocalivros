import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trocalivros/view/EmprDetalhesLivro.dart';
import 'package:trocalivros/view/ctrlDetalheLivros.dart';

import 'package:trocalivros/view/ctrldeLivro.dart';
import 'package:trocalivros/view/ctrldeUsuario.dart';
import 'package:trocalivros/view/custom_drawer.dart';
import 'package:trocalivros/model/book.dart';
import 'package:trocalivros/view/telaDetalhesLivro.dart';

class ListatLivros extends StatelessWidget {
  const ListatLivros({super.key});

  @override
  Widget build(BuildContext context) {

    final CtrlLivro _ctrlLivro = Get.find();
    final CtrlUsuario _ctrlUsuario = Get.put(CtrlUsuario());


    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Livros'),
      ),
      body: FutureBuilder<List<Livro>>(
        future: _ctrlLivro.listarmeusLivros(email:_ctrlUsuario.user?.email ?? 'murillo.jose@estudante.ifro.edu.br'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar livros: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Livro livro = snapshot.data![index];
                return GestureDetector(
                  onTap: (){

                    final CtrlDetalheLivros _ctrlDetalheLivros = Get.put(CtrlDetalheLivros(livro));

                    Get.to(() => TelaDetalhesLivro())?.then((value) {

                      _ctrlDetalheLivros.LimparCtrl();
                    });

                  },
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('${livro.capa}'),
                      ),
                      title: Text('Nome do Livro: ${livro.nome} - ISBN: ${livro.isbn}'),
                      subtitle: Text(livro.sinopse, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
