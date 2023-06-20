import '../model/usuario.dart';


Future<Usuario> criarUsuario(context, String nome, String dataNascimento, String emailUser, String endereco, String telefone) async {
  var usuario = Usuario(
      nome: '${nome}',
      dataNascimento: '${dataNascimento}',
      emailUser: '${emailUser}',
      endereco: '${endereco}',
      telefone: '${telefone}');
  return usuario;
}