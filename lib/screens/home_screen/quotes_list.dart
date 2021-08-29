import 'package:animebook/bloc/quotes_bloc.dart';
import 'package:animebook/models/anime_quote_model.dart';
import 'package:animebook/screens/anime_list/anime_list.dart';
import 'package:animebook/screens/home_screen/quotes_option.dart';
import 'package:animebook/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class QuotesList extends StatefulWidget {
  const QuotesList({Key? key}) : super(key: key);

  @override
  _QuotesListState createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> {
  final ScrollController _scrollController = ScrollController();
  QuotesBloc quotesBloc = QuotesBloc();
  QuoteStatus quoteStatus = QuoteStatus.initial;

  @override
  void initState() {
    super.initState();
    quotesBloc = context.read<QuotesBloc>();
    quotesBloc.add(LoadQuotes());
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener<QuotesBloc, QuotesState>(
        listener: (context, state) {
          setState(() {
            quoteStatus = state.quoteStatus;
          });
        },
        child: BlocBuilder<QuotesBloc, QuotesState>(
          builder: (cotext, state) {
            if (quoteStatus == QuoteStatus.initial) {
              return Center(child: CircularProgressIndicator());
            }
            if (quoteStatus == QuoteStatus.failure) {
              return Center(
                child: Text("Failed to Load Data"),
              );
            }
            if (quoteStatus == QuoteStatus.success) {
              return Column(children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: state.hasReachedMax
                        ? state.animeQuotes.length
                        : state.animeQuotes.length + 1,
                    itemBuilder: (context, index) {
                      return index >= state.animeQuotes.length
                          ? BottomLoader()
                          : QuoteCard(
                              animeQuote: state.animeQuotes[index],
                              isCLickable: true,
                            );
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AnimeList()));
                    },
                    child: Text("Anime List"),
                  ),
                ),
                SizedBox(height: 10.0),
              ]);
            }
            return Text(Global.defaultText);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    quotesBloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) quotesBloc.add(LoadQuotes());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class QuoteCard extends StatelessWidget {
  final AnimeQuotes animeQuote;
  final bool isCLickable;
  const QuoteCard({
    Key? key,
    required this.animeQuote,
    this.isCLickable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isCLickable) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => QuotesOptions(
              animeQuotes: animeQuote,
            ),
          ));
        }
      },
      child: Container(
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
            Text(animeQuote.quote ?? ""),
            SizedBox(height: 10.0),
            Row(
              children: [
                Spacer(),
                Container(
                  width: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SelectableText("~ ${animeQuote.character}"),
                      Text(
                        "${animeQuote.anime}",
                        textAlign: TextAlign.right,
                        softWrap: true,
                        maxLines: 2,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: Global.borderRadius,
        ),
        child: Container(),
      ),
    );
  }
}
