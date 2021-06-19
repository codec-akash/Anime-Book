import 'package:animebook/bloc/quotes_bloc.dart';
import 'package:animebook/models/anime_quote_model.dart';
import 'package:animebook/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuotesList extends StatefulWidget {
  const QuotesList({Key? key}) : super(key: key);

  @override
  _QuotesListState createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> {
  ScrollController _scrollController = ScrollController();
  QuotesBloc quotesBloc = QuotesBloc();

  @override
  void initState() {
    quotesBloc = BlocProvider.of<QuotesBloc>(context);
    quotesBloc.add(LoadQuotes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<QuotesBloc, QuotesState>(
        builder: (cotext, state) {
          if (state is QuotesLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is QuotesLoaded) {
            return ListView.builder(
                controller: _scrollController,
                itemCount: state.animeQuotes.length,
                itemBuilder: (context, index) {
                  return QuoteCard(
                    animeQuote: state.animeQuotes[index],
                  );
                });
          }
          if (state is QuotesEventFailed) {
            return Center(
              child: Text("Error Occured -- ${state.errorMessage}"),
            );
          }
          print("State - $state");
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class QuoteCard extends StatelessWidget {
  final AnimeQuotes? animeQuote;
  const QuoteCard({Key? key, this.animeQuote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: Global.borderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(animeQuote?.quote ?? ""),
          SizedBox(height: 10.0),
          Row(
            children: [
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("~ ${animeQuote?.character}"),
                  Text("${animeQuote?.anime}")
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
