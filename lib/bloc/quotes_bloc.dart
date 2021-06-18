import 'dart:async';

import 'package:animebook/models/anime_quote_model.dart';
import 'package:animebook/repository/anime_quotes.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quotes_event.dart';
part 'quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  final QuotesApi quotesApi;
  QuotesBloc(this.quotesApi) : super(QuotesUninitialized()) {
    print("Quotes bloc created");
    add(LoadQuotes());
  }

  @override
  Stream<QuotesState> mapEventToState(
    QuotesEvent event,
  ) async* {
    print("Called Load");
    yield QuotesLoading();
    print(event);
    if (event is LoadQuotes) {
      print("Called");
      await Future.delayed(Duration(milliseconds: 500));
      try {
        List<AnimeQuotes> animeQuotes = await quotesApi.getAnimeQuotes();
        print("Result Yield");
        yield QuotesLoaded(animeQuotes);
      } catch (e) {
        yield QuotesEventFailed(errorMessage: e.toString());
      }
    }
  }
}
