import 'package:animebook/bloc/quotes_bloc.dart';
import 'package:animebook/models/anime_quote_model.dart';
import 'package:animebook/screens/anime_list/anime_quote_list.dart';
import 'package:animebook/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({Key? key}) : super(key: key);

  @override
  _AnimeListState createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  QuotesBloc _quotesBloc = QuotesBloc();
  List<String> searchableAnime = [];

  void searchFn(value, List<String> animeQuotes) {
    setState(() {
      searchableAnime = animeQuotes
          .where((element) => element.toLowerCase().contains(value))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _quotesBloc = context.read<QuotesBloc>();
    _quotesBloc.add(LoadAnimeList());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _quotesBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anime List"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<QuotesBloc>().add(LoadAnimeList());
        },
        child: BlocBuilder<QuotesBloc, QuotesState>(
          bloc: _quotesBloc,
          builder: (context, state) {
            if (state is QuotesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is QuotesEventFailed) {
              print(state.errorMessage);
              return Center(
                child: Text("Failed to Load Data"),
              );
            }
            if (state is AnimeListLoaded) {
              print("Loased");
              return Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search bar',
                      ),
                      onChanged: (value) {
                        searchFn(value, state.animeList);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchableAnime.isEmpty
                          ? state.animeList.length
                          : searchableAnime.length,
                      itemBuilder: (context, index) {
                        return searchableAnime.length > 0
                            ? AnimeListCard(
                                animeName: "${searchableAnime[index]}")
                            : AnimeListCard(
                                animeName: "${state.animeList[index]}");
                      },
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Text("Nice Text"),
            );
          },
        ),
      ),
    );
  }
}

class AnimeListCard extends StatelessWidget {
  final String animeName;
  const AnimeListCard({Key? key, required this.animeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AnimeQuoteList(titleName: animeName),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: Global.borderRadius,
        ),
        child: Text(
          "$animeName",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
