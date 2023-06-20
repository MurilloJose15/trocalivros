import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trocalivros/model/book.dart';
import 'package:trocalivros/model/usuario.dart';
import 'package:trocalivros/view/ctrldeLivro.dart';
import 'package:trocalivros/view/ctrldeUsuario.dart';

import '../modelview/estruturaUsuario.dart';
import 'custom_drawer.dart';


class CadUsuario extends StatefulWidget {
  @override
  State<CadUsuario> createState() => _CadUsuarioState();
}

class _CadUsuarioState extends State<CadUsuario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  final TextEditingController _emailUserController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();

  final CtrlUsuario _ctrlUsuario = Get.put(CtrlUsuario());

  late final Usuario usuario;

  @override
  void dispose() {
    _nameController.dispose();
    _dataNascimentoController.dispose();
    _emailUserController.dispose();
    _enderecoController.dispose();
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Usuario'),
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
                    labelText: 'Nome Completo', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome completo';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
              child: TextFormField(
                controller: _dataNascimentoController,
                decoration: InputDecoration(
                    labelText: 'Data de Nascimento', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o sua Data de Nascimento';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
              child: TextFormField(
                controller: _emailUserController,
                maxLines: null,
                decoration: InputDecoration(
                    labelText: 'email', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu email';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
              child: TextFormField(
                controller: _enderecoController,
                maxLines: null,
                decoration: InputDecoration(
                    labelText: 'endereço completo', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu endereço';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
              child: TextFormField(
                controller: _telefoneController,
                maxLines: null,
                decoration: InputDecoration(
                    labelText: 'telefone', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o seu telefone';
                  }
                  return null;
                },
              ),
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
                    usuario = await criarUsuario(
                        context,
                        _nameController.text,
                        _dataNascimentoController.text,
                        _emailUserController.text,
                        _enderecoController.text,
                        _telefoneController.text);

                    print(usuario.nome);
                    await _ctrlUsuario.salvarUsuario(context, usuario);
                    _nameController.clear();
                    _dataNascimentoController.clear();
                    _emailUserController.clear();
                    _enderecoController.clear();
                    _telefoneController.clear();
                    Future.delayed(Duration(seconds: 3), () {
                      Get.close(1);
                    });

                  }
                },
                child: Text('Cadastrar Usuario'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
