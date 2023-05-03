part of 'search_bloc.dart';

class SearchState extends Equatable {
  final bool displayManualMarket;

  const SearchState({this.displayManualMarket = false});

  SearchState copyWith({bool? displayManualMarket}) {
    print('DisplayManualMarket: ' + displayManualMarket.toString());
    return SearchState(
        displayManualMarket: displayManualMarket ?? this.displayManualMarket);
  }

  @override
  List<Object> get props => [];
}
