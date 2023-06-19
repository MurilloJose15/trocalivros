import '../model/book.dart';

Future<Livro> criarLivro(context, String nome, String emailDono, String sinopse, String ISBN, String urlCapaLivro) async {
  var livro = Livro(
      nome: '${nome}',
      emailDono: '${emailDono}',
      sinopse: '${sinopse}',
      isbn: '${ISBN}',
      capa: '${urlCapaLivro}');
  return livro;
}