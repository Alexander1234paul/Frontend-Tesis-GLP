import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_tesis_glp/bloc/map/map_bloc.dart';

class BtnToggleUserRoute extends StatelessWidget {
  const BtnToggleUserRoute({super.key});
  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 30,
          child: IconButton(
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              mapBloc.add(OnToggleUserRoute());
            },
          )),
    );
  }
}
