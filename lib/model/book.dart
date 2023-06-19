class Livro {
  String nome;
  String emailDono;
  String sinopse;
  String isbn;
  String capa;

  Livro({
    required this.nome,
    required this.emailDono,
    required this.sinopse,
    required this.isbn,
    required this.capa,
  });

  factory Livro.fromMap(Map<String, dynamic> map) {
    return Livro(
      nome: map['nome'],
      emailDono: map['emailDono'],
      sinopse: map['sinopse'],
      isbn: map['isbn'],
      capa: map['capa'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'emailDono': emailDono,
      'sinopse': sinopse,
      'isbn': isbn,
      'capa': capa,
    };
  }

  factory Livro.fromJson(Map<String, dynamic> json, String id) {
    return Livro(
        nome: json['nome'],
        emailDono: json['emailDono'],
        sinopse: json['sinopse'],
        isbn: json['isbn'],
        capa: json['capa'],
    );
  }
}