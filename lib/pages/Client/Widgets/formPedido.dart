import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_tesis_glp/bloc/MapClient/map_cliente_bloc.dart';
import 'package:frontend_tesis_glp/utils/responsive.dart';
import 'package:frontend_tesis_glp/widgets/input_text_login.dart';
import 'package:frontend_tesis_glp/widgets/searchbart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../bloc/location/location_bloc.dart';
import '../../../services/auth_service.dart';
import '../../../services/request.dart';
import '../../../widgets/roudend_button.dart';

class FormPedido extends StatefulWidget {
  const FormPedido({super.key});

  @override
  State<FormPedido> createState() => _FormPedidoState();
}

class _FormPedidoState extends State<FormPedido> {
  final LocationBloc locationBloc = LocationBloc();
  final RequestHttp requestHttp = RequestHttp();
  final MapClienteBloc mapClienteBloc = MapClienteBloc();

  int numCilindros = 1;

  void _submit(LatLng ubicacion) async {
    await requestHttp.newOrderCliente(numCilindros.toString(),
        ubicacion.longitude.toString(), ubicacion.latitude.toString());
    //

    mapClienteBloc.add(isTrueSlideEvent());
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    double a = 4;

    return BlocBuilder  <LocationBloc, LocationState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: (responsive.height / 2) * 1.22),
            padding: EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: responsive.height * 0.35,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFFA72138), // Color de la línea superior
                  width: 20.0, // Grosor de la línea superior
                ),
              ),
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                children: [
                  SearchBar(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (numCilindros < 2) {
                            setState(() {
                              numCilindros = numCilindros + 1;
                            });
                          }
                        },
                        icon: Icon(Icons.add),
                        iconSize: 24,
                      ),
                      Column(
                        children: [
                          Text(numCilindros.toString()),
                          Text('Cilindros'),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (numCilindros > 1) {
                              numCilindros = numCilindros - 1;
                            }
                          });
                        },
                        icon: Icon(Icons.remove),
                        iconSize: 24,
                      ),
                    ],
                  ),
                  InputText(
                    label: 'Opciones y Comentarios',
                    size: 12,
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RoundedButton(
                    onPressed: () => _submit(state.lastKnownLocation!),
                    label: 'Pedir',
                    backgroundColor: Color(0xFFA72138),
                    size: responsive.width * 0.8,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
