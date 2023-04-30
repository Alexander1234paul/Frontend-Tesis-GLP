part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnable;
  final bool isGpsPermissionGranted;
  const GpsState(
      {required this.isGpsEnable, required this.isGpsPermissionGranted});

  @override
  List<Object> get props => [isGpsEnable, isGpsPermissionGranted];
}
