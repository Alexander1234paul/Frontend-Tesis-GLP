import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_tesis_glp/bloc/MapClient/map_cliente_bloc.dart';
import 'package:frontend_tesis_glp/bloc/gps/gps_bloc.dart';
import 'package:frontend_tesis_glp/bloc/location/location_bloc.dart';
import 'package:frontend_tesis_glp/bloc/map/map_bloc.dart';
import 'package:frontend_tesis_glp/bloc/search/search_bloc.dart';
import 'package:frontend_tesis_glp/bloc/socket/socket_bloc.dart';
import 'package:frontend_tesis_glp/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:frontend_tesis_glp/services/traffic_services.dart';

// void main() => runApp(const MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Future<String?> getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }

  final token = await getToken();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(
        create: (context) => LocationBloc(),
      ),
      BlocProvider(
        create: (context) =>
            MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context)),
      ),
      BlocProvider(
        create: (context) => SearchBloc(trafficService: TrafficService()),
      ),  
      BlocProvider(create: (context) => MapClienteBloc()),
      BlocProvider(create: (context) => SocketBloc(token!)),
    ],
    child: const MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'sans'),
      title: 'Material App',
      initialRoute: 'loading',
      // initialRoute: 'loadMap',
      // initialRoute: 'login',

      routes: appRoutes,
    );
  }
}
