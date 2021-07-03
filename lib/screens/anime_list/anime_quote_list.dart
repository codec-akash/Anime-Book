import 'package:animebook/bloc/quotes_bloc.dart';
import 'package:animebook/screens/home_screen/quotes_list.dart';
import 'package:animebook/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeQuoteList extends StatelessWidget {
  final String titleName;
  const AnimeQuoteList({Key? key, required this.titleName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$titleName"),
      ),
      body: Container(
        child: BlocBuilder<QuotesBloc, QuotesState>(
          bloc: QuotesBloc()..add(LoadAnimeQuotes(animeName: titleName)),
          builder: (context, state) {
            if (state is QuotesLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is QuotesLoaded) {
              return ListView.builder(
                itemCount: state.animeQuotesList.length,
                itemBuilder: (context, index) => QuoteCard(
                  animeQuote: state.animeQuotesList[index],
                ),
              );
            }
            return Center(
              child: Text(Global.defaultText),
            );
          },
        ),
      ),
    );
  }
}
