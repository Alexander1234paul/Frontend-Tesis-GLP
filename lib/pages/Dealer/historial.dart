import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../global/environment.dart';

class HistoryOrderDealer extends StatefulWidget {
  @override
  State<HistoryOrderDealer> createState() => _HistoryOrderDealerState();
}

class _HistoryOrderDealerState extends State<HistoryOrderDealer> {
  Future<String?> getToken() async {
    // Obtener el token desde el almacenamiento seguro
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    return token;
  }

  Future<List<Map<String, dynamic>>> getCompletedOrders() async {
    final String urlMain = Environment.apiUrl;
    final url = Uri.parse(urlMain + 'getBackOrderByDealer');
    print(url);

    String? token = await getToken();
    String estado = 'proceso';

    // Construir la URL con los parámetros requeridos
    Uri requestUrl = Uri.parse(url.toString() +
        '?token=$token&estado=$estado');

    final response = await http.get(requestUrl);
    var responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      List<dynamic> orders = responseData['result'];
      List<Map<String, dynamic>> completedOrders = [];
      for (var order in orders) {
        completedOrders.add(order);
      }
      return completedOrders;
    } else {
      throw Exception('Failed to fetch completed orders');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    try {
      List<Map<String, dynamic>> completedOrders = await getCompletedOrders();
      // Imprimir la lista de pedidos completados
      print(completedOrders);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA72138),
        title: Text('Historial de pedidos'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getCompletedOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> completedOrders = snapshot.data!;
            return ListView.builder(
              itemCount: completedOrders.length,
              itemBuilder: (context, index) {
                var order = completedOrders[index];
                String fecha = DateTime.fromMillisecondsSinceEpoch(
                        order['Cliente']['fecha']['_seconds'] * 1000)
                    .toString();
                String numCilindro = order['Cliente']['numCilindro'];
                String atendidoPor = order['Distribuidor']['id'];
                String estado = order['estado'];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text((index + 1).toString()),
                    ),
                    title: Text('Fecha: $fecha'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Número de cilindros: $numCilindro'),
                        Text('Atendido por: $atendidoPor'),
                        Text('Estado: $estado'),
                      ],
                    ),
                    // Agrega más información de la orden si es necesario
                  ),
                );
              },
            );
         } else {
            return Text('No se encontraron pedidos completados.');
          }
        },
      ),
    );
  }
}
