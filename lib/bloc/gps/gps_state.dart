part of 'gps_bloc.dart';

// Definición de la clase GpsState que extiende la clase Equatable
class GpsState extends Equatable {
// Campos obligatorios que indican si el GPS está habilitado y si la aplicación tiene permiso para acceder a la ubicación
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

// Getter que devuelve si tanto el GPS como el permiso para acceder a la ubicación están concedidos
  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;

// Constructor de la clase GpsState
  const GpsState(
      {required this.isGpsEnabled, required this.isGpsPermissionGranted});

// Método que devuelve una nueva instancia de GpsState con los campos actualizados
  GpsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
  }) =>
      GpsState(
          isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
          isGpsPermissionGranted:
              isGpsPermissionGranted ?? this.isGpsPermissionGranted);

// Método que devuelve una lista de objetos utilizados por Equatable para determinar si dos objetos son iguales
  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];

// Método que devuelve una cadena de texto representando el objeto
  @override
  String toString() =>
      '{ isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted }';
}
