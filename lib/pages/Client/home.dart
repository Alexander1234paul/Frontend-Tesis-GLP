import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_tesis_glp/pages/Client/Widgets/Slide.dart';
import 'package:frontend_tesis_glp/widgets/btn_elevate.dart';
import 'package:frontend_tesis_glp/widgets/manual_marker.dart';
import 'package:frontend_tesis_glp/widgets/map_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../bloc/MapClient/map_cliente_bloc.dart';
import '../../bloc/location/location_bloc.dart';
import '../../bloc/map/map_bloc.dart';
import 'Widgets/formPedido.dart';

class HomeClient extends StatefulWidget {
  const HomeClient({super.key});

  @override
  State<HomeClient> createState() => _HomeClientState();
}

class _HomeClientState extends State<HomeClient> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnownLocation == null) {
            return const Center(child: Text('Espere por favor...'));
          }
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              Map<String, Polyline> polylines = Map.from(mapState.polylines);

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                        initialLocation: locationState.lastKnownLocation!,
                        polylines: polylines.values.toSet(),
                        markers: mapState.markers.values.toSet()),
                    BlocBuilder<MapClienteBloc, MapClienteState>(
                      builder: (context, state) {
                        return !state.isSlide
                            ? Stack(
                                children: [
                                  FormPedido(),
                                  BtnElevate(),
                                ],
                              )
                            : Slide();
                      },
                    ),

                    //  ManualMarker()
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
