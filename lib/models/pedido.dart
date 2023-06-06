class Pedido {
  String estado;
  Cliente cliente;
  String id;

  Pedido({required this.estado, required this.cliente, required this.id});

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      estado: json['estado'],
      cliente: Cliente.fromJson(json['Cliente']),
      id: json['id'],
    );
  }
}

class Cliente {
  int numCilindro;
  String fecha;
  String idCliente;
  List<double> location;

  Cliente(
      {required this.numCilindro,
      required this.fecha,
      required this.idCliente,
      required this.location});

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      numCilindro: json['numCilindro'],
      fecha: json['fecha'],
      idCliente: json['idCliente'],
      location: List<double>.from(json['location'].map((x) => x.toDouble())),
    );
  }
}
