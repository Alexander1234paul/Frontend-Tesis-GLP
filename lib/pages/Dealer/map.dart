import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_tesis_glp/bloc/blocs.dart';
import 'package:frontend_tesis_glp/bloc/dealer/map_dealer_bloc.dart';
import 'package:frontend_tesis_glp/bloc/location/location_bloc.dart';
import 'package:frontend_tesis_glp/pages/Dealer/Widgets/slide.dart';
import 'package:frontend_tesis_glp/widgets/btn_follow_user.dart';
import 'package:frontend_tesis_glp/widgets/btn_location.dart';
import 'package:frontend_tesis_glp/widgets/btn_toggle_user_route.dart';
import 'package:frontend_tesis_glp/widgets/manual_marker.dart';
import 'package:frontend_tesis_glp/widgets/searchbart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart' as material;

import '../../bloc/search/search_bloc.dart';
import '../../bloc/socket_client/socket_bloc.dart';
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

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);
    mapDealerBloc = BlocProvider.of<MapDealerBloc>(context);
    searchBloc = BlocProvider.of<SearchBloc>(context);
    mapBloc = BlocProvider.of<MapBloc>(context);

    locationBloc.startFollowingUser();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _initializeMap();
    });
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  Future<void> _initializeMap() async {
    final locationState = locationBloc.state;
    final mapState = mapBloc.state;
    final dealerState = mapDealerBloc.state;

    if (locationState.lastKnownLocation == null ||
        mapState.polylines.isEmpty ||
        dealerState.knownLocationClient == null) {
      await Future.delayed(const Duration(seconds: 1));
      _initializeMap();
    } else {
      _drawRoute(locationState.lastKnownLocation!, dealerState.knownLocationClient!);
    }
  }

  Future<void> _drawRoute(LatLng start, LatLng end) async {
    final destination = await searchBloc.getCoorsStartToEnd(start, end);
    await mapBloc.drawRoutePolyline(destination);
    searchBloc.add(OnDeactivateManualMarkerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MapDealerBloc, MapDealerState>(
        listener: (context, state) {
          if (state.idDocument != null) {
            final locationState = locationBloc.state;
            final socketBloc = BlocProvider.of<SocketBloc>(context);
            socketBloc.socket.emit('get-location', {
              'idDocument': state.idDocument,
              'location': locationState.lastKnownLocation,
            });
          }
        },
        builder: (context, state) {
          return BlocConsumer<LocationBloc, LocationState>(
            listener: (context, locationState) {
              if (locationState.lastKnownLocation != null) {
                final socketBloc = BlocProvider.of<SocketBloc>(context);
                socketBloc.socket.emit('get-location', {
                  'idDocument': state.idDocument,
                  'location': locationState.lastKnownLocation,
                });
              }
            },
            builder: (context, locationState) {
              if (locationState.lastKnownLocation == null) {
                return const Center(child: CircularProgressIndicator());
              }

              return BlocBuilder<MapBloc, MapState>(
                builder: (context, mapState) {
                  final polylines = mapState.polylines;
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
