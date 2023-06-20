class Usuario {
  String nome;
  String dataNascimento;
  String emailUser;
  String endereco;
  String telefone;

  Usuario({
    required this.nome,
    required this.dataNascimento,
    required this.emailUser,
    required this.endereco,
    required this.telefone,
  });

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'],
      dataNascimento: map['dataNascimento'],
      emailUser: map['emailUser'],
      endereco: map['endereco'],
      telefone: map['telefone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'dataNascimento': dataNascimento,
      'emailUser': emailUser,
      'endereco': endereco,
      'telefone': telefone,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json, String id) {
    return Usuario(
        nome: json['nome'],
        dataNascimento: json['dataNascimento'],
        emailUser: json['emailUser'],
        endereco: json['endereco'],
        telefone: json['telefone'],
    );
  }
}