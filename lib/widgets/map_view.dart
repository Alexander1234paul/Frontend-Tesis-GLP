import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_tesis_glp/bloc/map/map_bloc.dart';
import 'package:frontend_tesis_glp/bloc/map/map_bloc.dart';
import 'package:frontend_tesis_glp/utils/responsive.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViews extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Polyline> polylines;
  const MapViews(
      {super.key, required this.initialLocation, required this.polylines});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    Responsive responsive = Responsive.of(context);
    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 15);

    return SizedBox(
        width: responsive.width,
        height: responsive.height,
        child: Listener(
          onPointerMove: (PointerMoveEvent) =>
              mapBloc.add(OnStopFollowingUserEvent()),
          child: GoogleMap(
            initialCameraPosition: initialCameraPosition,
            compassEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            myLocationButtonEnabled: true,
            polylines: polylines,
            onMapCreated: (controller) =>
                mapBloc.add(OnMapIntializeEvent(controller)),
          ),
        ));
  }
}
