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

  late LatLng initialLocation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          if (locationState.lastKnowLocation == null) {
            return const Center(
              child: Text('Espere porfavor...'),
            );
          }
          return BlocBuilder<MapBloc, MapState>(
            builder: (context, mapState) {
              Map<String, Polyline> polylines = Map.from(mapState.polylines);
              if (!mapState.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapViews(
                      initialLocation: locationState.lastKnowLocation!,
                      polylines: polylines.values.toSet(),
                      //TODO tonones:
                    ),
                    const SearchBar(),
                    const ManualMarker()
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            BtnToggleUserRoute(),
            BtnCurrentLocation(),
            BtnFollowUser()
          ]),
    );
  }
}
