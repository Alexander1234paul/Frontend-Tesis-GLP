import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'socket_dealer_event.dart';
part 'socket_dealer_state.dart';

class SocketDealerBloc extends Bloc<SocketDealerEvent, SocketDealerState> {
  SocketDealerBloc() : super(SocketDealerInitial()) {
    on<SocketDealerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
