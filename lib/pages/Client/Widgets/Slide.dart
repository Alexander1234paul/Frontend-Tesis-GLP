import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/MapClient/map_cliente_bloc.dart';

class Slide extends StatelessWidget {
  const Slide({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final mapClienteBloc = BlocProvider.of<MapClienteBloc>(context);

    return Row(
      children: [
        Container(
          width: 290,
          height: screenSize.height,
          color: Color.fromARGB(255, 255, 255, 255),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const _DrawerHeader(),
              ListTile(
                leading: const Icon(Icons.pages_outlined),
                title: const Text('Home'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.people_outline),
                title: const Text('People'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Settings'),
                onTap: () {
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              print('Se hizo clic en el segundo contenedor');
              mapClienteBloc.add(isFalseSlideEvent());
            },
            child: Container(
              width: 100,
              height: screenSize.height,
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/menu-img.jpg'), fit: BoxFit.cover)),
    );
  }
}
