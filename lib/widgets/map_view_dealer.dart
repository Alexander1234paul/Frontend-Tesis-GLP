import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_tesis_glp/bloc/map/map_bloc.dart';
import 'package:frontend_tesis_glp/bloc/map/map_bloc.dart';
import 'package:frontend_tesis_glp/utils/responsive.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapViewDealer extends StatelessWidget {
  final LatLng initialLocation; // La ubicación inicial que se mostrará en el mapa
  final Set<Polyline> polylines; // Conjunto de polilíneas a dibujar en el mapa
  final Set<Marker> markers; // Conjunto de marcadores a mostrar en el mapa

  const MapViewDealer({
    Key? key,
    required this.initialLocation,
    required this.polylines,
    required this.markers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context); // Obtiene la instancia de MapBloc del contexto

    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 15); // Posición inicial de la cámara

    final size = MediaQuery.of(context).size; // Tamaño de la pantalla del dispositivo

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (pointerMoveEvent) =>
            mapBloc.add(OnStopFollowingUserEvent()), // Si se mueve el dedo sobre el mapa, se deja de seguir al usuario
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false, // Desactiva la brújula en la parte superior izquierda del mapa
          myLocationEnabled: true, // Activa la ubicación del usuario en el mapa
          zoomControlsEnabled: false, // Desactiva los controles de zoom del mapa
          myLocationButtonEnabled: false, // Desactiva el botón de ubicación del usuario en el mapa
          polylines: polylines, // Agrega las polilíneas al mapa
          markers: markers, // Agrega los marcadores al mapa
          onMapCreated: (controller) => mapBloc.add(OnMapInitialzedEvent(controller)), // Se llama cuando el mapa es creado y se guarda el controlador del mapa en el MapBloc
          onCameraMove: (position) => mapBloc.mapCenter = position.target, // Se llama cuando se mueve la cámara y actualiza el centro del mapa en el MapBloc
          // TODO: Markers
          // onCameraMove: ,
        ),
      ),
    );
  }
}
