import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
// Declaración de la variable gpsServiceSubscription, que se utiliza para almacenar la suscripción
// a un flujo de datos de servicio de ubicación.
  StreamSubscription? gpsServiceSubscription;

  // Constructor del BLoC, aquí se inicializa el estado inicial y se asigna el listener
  // para el evento GpsAndPermissionEvent
  GpsBloc()
      : super(const GpsState(
            isGpsEnabled: false, isGpsPermissionGranted: false)) {
    // Este método se activa cuando se emite un evento de tipo GpsAndPermissionEvent.
    // Toma el evento y el objeto "emit" que se usa para enviar un nuevo estado al Stream de estados del BLoC.
    // Se utiliza el método "copyWith" del estado actual del BLoC para crear un nuevo estado con los campos "isGpsEnabled"
    // y "isGpsPermissionGranted" actualizados con los valores del evento. Luego, se emite el nuevo estado al Stream.
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
        isGpsEnabled: event.isGpsEnabled,
        isGpsPermissionGranted: event.isGpsPermissionGranted)));

    // Llamar al método privado _init() para inicializar los valores de GPS y permiso
    _init();
  }

  // Método privado para inicializar los valores de GPS y permiso
  Future<void> _init() async {
    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);

    // Emitir el evento GpsAndPermissionEvent con los valores iniciales de GPS y permiso
    add(GpsAndPermissionEvent(
      isGpsEnabled: gpsInitStatus[0],
      isGpsPermissionGranted: gpsInitStatus[1],
    ));
  }

  // Método privado para comprobar si se ha concedido el permiso de ubicación
  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  // Método privado para comprobar si el GPS está habilitado
  Future<bool> _checkGpsStatus() async {
    // Verificar si el servicio de ubicación está habilitado
    final isEnable = await Geolocator.isLocationServiceEnabled();

    // Suscribirse a los cambios de estado del servicio GPS y actualizar el estado
    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      // Comprobar el índice del evento para determinar si el GPS está habilitado
      final isEnabled = (event.index == 1) ? true : false;
      // Emitir un evento con el estado actualizado del GPS
      add(GpsAndPermissionEvent(
        isGpsEnabled: isEnabled,
        isGpsPermissionGranted: state.isGpsPermissionGranted,
      ));
    });

    // Devolver el estado actual del GPS
    return isEnable;
  }

  // Método para solicitar acceso al GPS
  Future<void> askGpsAccess() async {
    // Solicitar acceso al GPS
    final status = await Permission.location.request();

    // Actualizar el estado en función del resultado de la solicitud de acceso
    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: true));
        break;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermissionEvent(
            isGpsEnabled: state.isGpsEnabled, isGpsPermissionGranted: false));
        openAppSettings(); // Abrir la configuración de la aplicación para que el usuario pueda conceder el permiso manualmente
    }
  }

  // Override del método close() para cancelar la suscripción al servicio GPS al cerrar el BLoC
  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}
