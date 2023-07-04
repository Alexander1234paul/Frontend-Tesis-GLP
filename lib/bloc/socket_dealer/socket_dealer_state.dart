part of 'socket_dealer_bloc.dart';

abstract class SocketDealerState extends Equatable {
  const SocketDealerState();
  
  @override
  List<Object> get props => [];
}

class SocketDealerInitial extends SocketDealerState {}
