import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_tesis_glp/bloc/blocs.dart';
import 'package:frontend_tesis_glp/bloc/dealer/map_dealer_bloc.dart';
import 'package:frontend_tesis_glp/bloc/location/location_bloc.dart';
import 'package:frontend_tesis_glp/widgets/btn_follow_user.dart';
import 'package:frontend_tesis_glp/widgets/btn_location.dart';
import 'package:frontend_tesis_glp/widgets/btn_toggle_user_route.dart';
import 'package:frontend_tesis_glp/widgets/manual_marker.dart';
import 'package:frontend_tesis_glp/widgets/searchbart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart' as material;

import '../../bloc/search/search_bloc.dart';
import '../../helpers/show_loading_message.dart';
import '../../widgets/map_view.dart';

class MapDealer extends StatefulWidget {
  const MapDealer({Key? key}) : super(key: key);

  @override
  State<MapDealer> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapDealer> {
  late LocationBloc locationBloc;
  late MapDealerBloc mapDealerBloc;
  late SearchBloc searchBloc;
  late MapBloc mapBloc;

  LatLng? start;
  LatLng? end;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    mapDealerBloc = BlocProvider.of<MapDealerBloc>(context);
    searchBloc = BlocProvider.of<SearchBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);

    locationBloc.startFollowingUser();

    start = locationBloc.state.lastKnownLocation;
    end = mapDealerBloc.state.knownLocationClient;
    end = LatLng(0.3484007866763723, -78.1284306196342);
    print('start');
    print(start);
    print('end');
    print(end);
    _drawRoute();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  Future<void> _drawRoute() async {
    // showLoadingMessage(context);
    final destination = await searchBloc.getCoorsStartToEnd(start!, end!);
    await mapBloc.drawRoutePolyline(destination);
    searchBloc.add(OnDeactivateManualMarkerEvent());
    //  Navigator.pop(context);
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

              if (!mapState.showMyRoute) {
                polylines.removeWhere((key, value) => key == 'myRoute');
              }

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    MapView(
                      initialLocation: locationState.lastKnownLocation!,
                      polylines: polylines.values.toSet(),
                      markers: mapState.markers.values.toSet(),
                    ),
                    // Resto de los widgets
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
          BtnFollowUser(),
          BtnCurrentLocation(),
        ],
      ),
    );
  }
}
