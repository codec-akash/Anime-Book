import 'package:animebook/models/anime_quote_model.dart';
import 'package:animebook/utils/global.dart';
import 'package:flutter/material.dart';

class QuotesList extends StatefulWidget {
  final List<AnimeQuotes>? animeQuotes;
  const QuotesList({Key? key, this.animeQuotes}) : super(key: key);

  @override
  _QuotesListState createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.animeQuotes?.length,
        itemBuilder: (context, index) => QuoteCard(
          animeQuote: widget.animeQuotes![index],
        ),
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
