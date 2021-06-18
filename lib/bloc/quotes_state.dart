part of 'quotes_bloc.dart';

abstract class QuotesState extends Equatable {
  const QuotesState();

  @override
  List<Object> get props => [];
}

class QuotesUninitialized extends QuotesState {}

class QuotesLoading extends QuotesState {}

class QuotesLoaded extends QuotesState {
  final List<AnimeQuotes> animeQuotes;

  List<AnimeQuotes> get getAnimeQuotes => animeQuotes;

  QuotesLoaded(this.animeQuotes);

  @override
  List<Object> get props => [animeQuotes];
}

class QuotesEventFailed extends QuotesState {
  final String? errorMessage;

  QuotesEventFailed({this.errorMessage});
}
