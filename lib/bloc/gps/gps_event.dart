part of 'gps_bloc.dart';

// Creación de una clase abstracta llamada GpsEvent, que extiende a Equatable
abstract class GpsEvent extends Equatable {
// Constructor vacío
  const GpsEvent();

// Sobrescritura del método props de Equatable, retornando una lista vacía
  @override
  List<Object> get props => [];
}

// Creación de una subclase llamada GpsAndPermissionEvent, que extiende a GpsEvent
class GpsAndPermissionEvent extends GpsEvent {
// Atributos booleanos que indican si el GPS está habilitado y si se concedió permiso de GPS
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

// Constructor que recibe los valores de los atributos
  const GpsAndPermissionEvent(
      {required this.isGpsEnabled, required this.isGpsPermissionGranted});
}
