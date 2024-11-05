class Visitor {
  String nome;
  String documento;
  DateTime horarioEntrada;
  String qrCode;

  Visitor({
    required this.nome,
    required this.documento,
    required this.horarioEntrada,
    required this.qrCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'documento': documento,
      'horario_entrada': horarioEntrada,
      'qr_code': qrCode,
    };
  }
}
