import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_tesis_glp/bloc/blocs.dart';
import 'package:frontend_tesis_glp/bloc/location/location_bloc.dart';
import 'package:frontend_tesis_glp/widgets/btn_follow_user.dart';
import 'package:frontend_tesis_glp/widgets/btn_location.dart';
import 'package:frontend_tesis_glp/widgets/btn_toggle_user_route.dart';
import 'package:frontend_tesis_glp/widgets/manual_marker.dart';
import 'package:frontend_tesis_glp/widgets/searchbart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/map_view.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

// Método que construye el widget de la pantalla
  @override
  Widget build(BuildContext context) {
// Retorna un Scaffold que contiene el cuerpo y los elementos flotantes del widget
    return Scaffold(
// El cuerpo del widget es un BlocBuilder que escucha el estado de la ubicación del usuario
      body: BlocBuilder<LocationBloc, LocationState>(
// Se construye el widget dependiendo del estado de la ubicación del usuario
        builder: (context, locationState) {
// Si la ubicación del usuario es null, se muestra un mensaje de espera
          if (locationState.lastKnownLocation == null) {
            return const Center(child: Text('Espere por favor...'));
          }
// Si la ubicación del usuario existe, se construye el widget con el estado del mapa
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
// Se crea una copia mutable del mapa de polilíneas del estado del mapa
              Map<String, Polyline> polylines = Map.from(mapState.polylines);
// Si la opción de mostrar la ruta del usuario está desactivada, se remueve la polilínea de la ruta del mapa
              if (!mapState.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }
// Se construye un SingleChildScrollView que contiene los elementos de la pantalla
              return SingleChildScrollView(
                child: Stack(
                  children: [
// El elemento principal de la pantalla es un MapView personalizado
                    MapView(
// La ubicación inicial del mapa es la última ubicación conocida del usuario
                      initialLocation: locationState.lastKnownLocation!,
// Las polilíneas a mostrar son las polilíneas del estado del mapa
                      polylines: polylines.values.toSet(),
// Los marcadores a mostrar son los marcadores del estado del mapa
                      markers: mapState.markers.values.toSet(),
                    ),
// También se muestra una barra de búsqueda y la opción de agregar marcadores manualmente
                    const SearchBar(),
                    const ManualMarker(),
                  ],
                ),
              );
            },
          );
        },
      ),
// El botón flotante es un menú desplegable que contiene tres botones
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // backgroundColor: Color.fromARGB(255, 0, 0, 0),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnToggleUserRoute(),
          BtnFollowUser(),
          BtnCurrentLocation(),
        ],
      ),
    );
  }
}
