import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/socket/socket_bloc.dart';
import '../models/band.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocketBloc, SocketState>(
      builder: (context, state) {
        final List<dynamic> pedidos = state.pedidos ?? [];

        return Scaffold(
          body: ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                child: Text(pedidos[index]['estado'].substring(0, 2)),
                backgroundColor: Colors.blue[100],
              ),
              title: Text(pedidos[index]['estado']),
              trailing: Text(
                '${pedidos[index]['id']}',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                print(pedidos[index]['id']);
                final socketBloc = BlocProvider.of<SocketBloc>(context);
                socketBloc.add(getPedidos(pedidos[index]['id']));
                socketBloc.socket.emit('nuevo-pedido', {
                  'token':
                      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZERvY3VtZW50byI6Im0xQkw5TklXamNXSTRSU3dQMTJ0IiwiaWF0IjoxNjg1NDE0MTMwLCJleHAiOjE2ODU0MjEzMzB9.pcFnNsaqfgJIZ_4kMQc1O_pmT1CMTv4wORtDk3DiXW4",
                  'latitud': 0.1,
                  'longitud': 0.1,
                  'numCilindro': 2,
                  'fecha': "2000-02-02",
                });
              },
            ),
          ),
        );
      },
    );
  }
}






// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Band> pedidos = [];

//   @override
//   void initState() {
//     super.initState();
//     Provider.of<SocketService>(context, listen: false)
//         .socket
//         .on('active-pedidos', _handleActiveBands);
//   }

//   void _handleActiveBands(dynamic payload) {
//     setState(() {
//       pedidos = (payload as List).map((band) => Band.fromMap(band)).toList();
//     });
//   }

//   @override
//   void dispose() {
//     Provider.of<SocketService>(context, listen: false)
//         .socket
//         .off('active-pedidos');
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final socketService = Provider.of<SocketService>(context);

//     return Scaffold(
//       body: ListView.builder(
//         itemCount: pedidos.length,
//         itemBuilder: (context, index) => ListTile(
//           leading: CircleAvatar(
//             child: Text(pedidos[index].name.substring(0, 2)),
//             backgroundColor: Colors.blue[100],
//           ),
//           title: Text(pedidos[index].name),
//           trailing: Text(
//             '${pedidos[index].votes}',
//             style: TextStyle(fontSize: 20),
//           ),
//           onTap: () =>
//               socketService.socket.emit('vote-band', {'id': pedidos[index].id}),
//         ),
//       ),
//     );
//   }
// }




//VALE PROVIDER

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   List<Band> pedidos = [];

//   @override
//   void initState() {
    
//     final socketService = Provider.of<SocketService>(context, listen: false);

//     socketService.socket.on('active-pedidos', _handleActiveBands );
//     super.initState();
//   }

//   _handleActiveBands( dynamic payload ) {

//     this.pedidos = (payload as List)
//         .map( (band) => Band.fromMap(band) )
//         .toList();

//     setState(() {});
//   }

//   @override
//   void dispose() {
//     final socketService = Provider.of<SocketService>(context, listen: false);
//     socketService.socket.off('active-pedidos');
//     super.dispose();
//   }


//   @override
//   Widget build(BuildContext context) {

//     final socketService = Provider.of<SocketService>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BandNames', style: TextStyle( color: Colors.black87 ) ),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         actions: <Widget>[
//           Container(
//             margin: EdgeInsets.only( right: 10 ),
//             child: ( socketService.serverStatus == ServerStatus.Online )
//               ? Icon( Icons.check_circle, color: Colors.blue[300] )
//               : Icon( Icons.offline_bolt, color: Colors.red ),
//           )
//         ],
//       ),
//       body: Column(
//         children: <Widget>[

//           Expanded(
//             child: ListView.builder(
//               itemCount: pedidos.length,
//               itemBuilder: ( context, i ) => _bandTile( pedidos[i] )
//             ),
//           )

//         ],
//       ),
     
//    );
//   }

//   Widget _bandTile( Band band ) {

//     final socketService = Provider.of<SocketService>(context, listen: false);

//     return Dismissible(
//       key: Key(band.id),
//       direction: DismissDirection.startToEnd,
//       onDismissed: ( _ ) => socketService.emit('delete-band', { 'id': band.id }),
//       background: Container(
//         padding: EdgeInsets.only( left: 8.0 ),
//         color: Colors.red,
//         child: Align(
//           alignment: Alignment.centerLeft,
//           child: Text('Delete Band', style: TextStyle( color: Colors.white) ),
//         )
//       ),
//       child: ListTile(
//         leading: CircleAvatar(
//           child: Text( band.name.substring(0,2) ),
//           backgroundColor: Colors.blue[100],
//         ),
//         title: Text( band.name ),
//         trailing: Text('${ band.votes }', style: TextStyle( fontSize: 20) ),
//         onTap: () => socketService.socket.emit('vote-band', { 'id': band.id } ) ,
//       ),
//     );
//   }

 

// }