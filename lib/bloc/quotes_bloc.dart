import 'dart:async';

import 'package:animebook/models/anime_quote_model.dart';
import 'package:animebook/repository/anime_quotes.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quotes_event.dart';
part 'quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  QuotesApi quotesApi = QuotesApi();
  List<AnimeQuotes> animeQuotes = [];
  QuotesBloc() : super(QuotesUninitialized()) {
    print("Quotes bloc created");
  }

  @override
  Stream<QuotesState> mapEventToState(
    QuotesEvent event,
  ) async* {
    yield QuotesLoading();
    print(event);
    if (event is LoadQuotes) {
      await Future.delayed(Duration(milliseconds: 500));
      try {
        List<AnimeQuotes> quotes = await quotesApi.getAnimeQuotes();
        animeQuotes.addAll(quotes);
        yield QuotesLoaded(animeQuotes);
      } catch (e) {
        yield QuotesEventFailed(errorMessage: e.toString());
      }
    }
  }
}
