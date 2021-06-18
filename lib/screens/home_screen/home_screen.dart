import 'package:animebook/bloc/quotes_bloc.dart';
import 'package:animebook/models/anime_quote_model.dart';
import 'package:animebook/repository/anime_quotes.dart';
import 'package:animebook/screens/home_screen/quotes_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AnimeQuotes> animeQuotes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Anime Quotes"),
      ),
      body: Column(
        children: [
          BlocProvider<QuotesBloc>(
            create: (context) => QuotesBloc(QuotesApi()),
            child: BlocBuilder<QuotesBloc, QuotesState>(
              builder: (cotext, state) {
                if (state is LoadQuotes) {
                  return CircularProgressIndicator();
                }
                if (state is QuotesLoaded) {
                  return QuotesList(animeQuotes: state.animeQuotes);
                }
                if (state is QuotesEventFailed) {
                  return Center(
                    child: Text("Error Occured -- ${state.errorMessage}"),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
