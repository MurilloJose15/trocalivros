import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trocalivros/model/book.dart';
import 'package:trocalivros/view/ctrldeLivro.dart';
import 'package:trocalivros/view/ctrldeUsuario.dart';

import '../modelview/estruturaLivro.dart';
import 'custom_drawer.dart';


class CadLivro extends StatefulWidget {
  @override
  State<CadLivro> createState() => _CadLivroState();
}

class _CadLivroState extends State<CadLivro> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ISBNController = TextEditingController();
  final TextEditingController _sinopseController = TextEditingController();

  final CtrlLivro ctrlLivro = Get.put(CtrlLivro());
  final CtrlUsuario _ctrlUsuario = Get.put(CtrlUsuario());
  bool _isCapa = false;
  String mensagem = 'A Capa ainda não foi carregada!';

  late final capa;
  late final urlCapa;
  late final Livro livro;

  @override
  void dispose() {
    _nameController.dispose();
    _ISBNController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Livro'),
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 30, 32, 10),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Título do Livro', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do Livro';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
              child: TextFormField(
                controller: _ISBNController,
                decoration: InputDecoration(
                    labelText: 'ISBN', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu ISBN';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
              child: TextFormField(
                controller: _sinopseController,
                maxLines: null,
                decoration: InputDecoration(
                    labelText: 'Sinopse', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a sua Sinopse';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _isCapa = true;
                        capa = await ctrlLivro.pickFile();
                        if (capa != null) {
                          setState(() {
                            _isCapa = false;
                            mensagem = 'Capa carregada com sucesso!';
                          });
                          print(capa.files.first.bytes);
                        }
                      }
                    },
                    child: Text('Selecionar Capa'),
                  ),
                  SizedBox(width: 25,),
                  ///_isCapa
                     /// ? LoadingAnimations(
                   /// cor: Colors.greenAccent,
                  ///)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 20,
                    child: Text('${mensagem}'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green)
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    urlCapa = await ctrlLivro.uploadFile(capa);
                    print(urlCapa);
                    livro = await criarLivro(
                        context,
                        _nameController.text,
                        _ctrlUsuario.user?.email ??
                            'murillo.jose@estudante.ifro.edu.br',
                        _sinopseController.text,
                        _ISBNController.text,
                        urlCapa);
                    print(livro.nome);
                    await ctrlLivro.salvarLivro(context, livro);
                    _nameController.clear();
                    _sinopseController.clear();
                    _ISBNController.clear();
                    Future.delayed(Duration(seconds: 3), () {
                      Get.close(1);
                    });

                  }
                },
                child: Text('Cadastrar Livro'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
