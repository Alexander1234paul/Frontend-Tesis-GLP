import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_tesis_glp/bloc/map/map_bloc.dart';
import 'package:frontend_tesis_glp/bloc/map/map_bloc.dart';
import 'package:frontend_tesis_glp/utils/responsive.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapView extends StatelessWidget {

  final LatLng initialLocation;
  final Set<Polyline> polylines;

  const MapView({ 
    Key? key, 
    required this.initialLocation, 
    required this.polylines 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition = CameraPosition(
        target: initialLocation,
        zoom: 15
    );

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: ( pointerMoveEvent )=> mapBloc.add( OnStopFollowingUserEvent() ),
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          polylines: polylines,
          onMapCreated: ( controller ) => mapBloc.add( OnMapInitialzedEvent(controller) ),
          onCameraMove: ( position ) => mapBloc.mapCenter = position.target
      
          // TODO: Markers
          // onCameraMove: ,
        ),
      ),
    );
  }
}