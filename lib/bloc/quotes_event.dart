part of 'quotes_bloc.dart';

abstract class QuotesEvent extends Equatable {
  const QuotesEvent();

  @override
  List<Object> get props => [];
}

class LoadQuotes extends QuotesEvent {}

class LoadAnimeList extends QuotesEvent {}

class LoadAnimeQuotes extends QuotesEvent {
  final String animeName;
  LoadAnimeQuotes({required this.animeName});
}
