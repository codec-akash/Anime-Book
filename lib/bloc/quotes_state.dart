part of 'quotes_bloc.dart';

enum QuoteStatus { initial, success, failure }

class QuotesState extends Equatable {
  const QuotesState({
    this.quoteStatus = QuoteStatus.initial,
    this.animeQuotes = const <AnimeQuotes>[],
    this.hasReachedMax = false,
  });

  final List<AnimeQuotes> animeQuotes;
  final QuoteStatus quoteStatus;
  final bool hasReachedMax;

  QuotesState copyWith(
      {QuoteStatus? quoteStatus,
      List<AnimeQuotes>? animeQuotes,
      bool? hasReachedMax}) {
    return QuotesState(
      quoteStatus: quoteStatus ?? this.quoteStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      animeQuotes: animeQuotes ?? this.animeQuotes,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $quoteStatus, hasReachedMax: $hasReachedMax, posts: ${animeQuotes.length} }''';
  }

  @override
  List<Object> get props => [quoteStatus, animeQuotes, hasReachedMax];
}

class QuotesUninitialized extends QuotesState {}

class QuotesLoading extends QuotesState {}

// class QuotesLoaded extends QuotesState {
//   final List<AnimeQuotes> animeQuotes;

//   List<AnimeQuotes> get getAnimeQuotes => animeQuotes;

//   QuotesLoaded(this.animeQuotes);

//   @override
//   List<Object> get props => [animeQuotes];
// }

class QuotesEventFailed extends QuotesState {
  final String? errorMessage;

  QuotesEventFailed({this.errorMessage});
}
