import 'dart:async';

import 'package:animebook/models/anime_quote_model.dart';
import 'package:animebook/repository/anime_quotes.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'quotes_event.dart';
part 'quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  QuotesApi quotesApi = QuotesApi();
  QuotesBloc() : super(QuotesUninitialized());

  @override
  Stream<Transition<QuotesEvent, QuotesState>> transformEvents(
      Stream<QuotesEvent> events,
      TransitionFunction<QuotesEvent, QuotesState> transitionFn) {
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<QuotesState> mapEventToState(QuotesEvent event) async* {
    if (event is LoadQuotes) {
      yield await _mapPostFetchedToState(state);
    }
  }

  Future<QuotesState> _mapPostFetchedToState(QuotesState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.quoteStatus == QuoteStatus.initial) {
        final quotes = await _fetchPosts();
        return state.copyWith(
          quoteStatus: QuoteStatus.success,
          animeQuotes: quotes,
          hasReachedMax: false,
        );
      }
      final quotes = await _fetchPosts(state.animeQuotes.length);
      return quotes.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              quoteStatus: QuoteStatus.success,
              animeQuotes: List.of(state.animeQuotes)..addAll(quotes),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(quoteStatus: QuoteStatus.failure);
    }
  }

  Future<List<AnimeQuotes>> _fetchPosts([int startIndex = 0]) async {
    try {
      final List<AnimeQuotes> animeQuotes = await quotesApi.getAnimeQuotes();
      return animeQuotes;
    } catch (e) {
      throw Exception('error fetching quotes');
    }
  }
}
