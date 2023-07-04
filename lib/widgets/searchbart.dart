import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_tesis_glp/bloc/blocs.dart';
import 'package:frontend_tesis_glp/bloc/search/search_bloc.dart';
import 'package:frontend_tesis_glp/bloc/search/search_bloc.dart';
import 'package:frontend_tesis_glp/delegates/search_destination_delegate.dart';
import 'package:frontend_tesis_glp/models/search_results.dart';

class SearchBarr extends StatelessWidget {
  const SearchBarr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return FadeInDown(
            duration: const Duration(milliseconds: 300),
            child: const _SearchBarBody());
      },
    );
  }
}

class _SearchBarBody extends StatelessWidget {
  const _SearchBarBody({Key? key}) : super(key: key);

  void onSearchResults(BuildContext context, SearchResult result) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    if (result.manual == true) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }

    if (result.position != null) {
      final destination = await searchBloc.getCoorsStartToEnd(
          locationBloc.state.lastKnownLocation!, result.position!);
      await mapBloc.drawRoutePolyline(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TextFormField(
        readOnly: true, 
       // Deshabilita la escritura en el TextFormField
        onTap: () async {
          final result = await showSearch(
              context: context, delegate: SearchDestinationDelegate());
          if (result == null) return;

          onSearchResults(context, result);
        },
        decoration: InputDecoration(
          filled: true,
          // fillColor: Color.fromARGB(66, 226, 31, 31),
          
          hintText: 'Mi ubicación',
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            // Acceder a la propiedad size de InputText
          ), // Marcador de posición
        ),
      ),
    );
  }
}
