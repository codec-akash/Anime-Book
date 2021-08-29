import 'package:animebook/models/anime_quote_model.dart';
import 'package:animebook/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class QuotesOptions extends StatefulWidget {
  final AnimeQuotes animeQuotes;
  const QuotesOptions({Key? key, required this.animeQuotes}) : super(key: key);

  @override
  _QuotesOptionsState createState() => _QuotesOptionsState();
}

class _QuotesOptionsState extends State<QuotesOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.animeQuotes.anime}"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40.0),
            ShareableQuoteCard(animeQuotes: widget.animeQuotes),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              width: double.infinity,
              child: ElevatedButton(
                child: Container(
                  child: Text("Share this"),
                ),
                onPressed: () {
                  Share.share("Share this quote with : ");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShareableQuoteCard extends StatelessWidget {
  final AnimeQuotes animeQuotes;
  const ShareableQuoteCard({Key? key, required this.animeQuotes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: Global.borderRadius20,
      ),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              child: LayoutBuilder(
                builder: (context, constraint) => Container(
                  height: constraint.maxHeight,
                  width: constraint.maxWidth,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: double.infinity,
                        maxWidth: MediaQuery.of(context).size.width * 2,
                      ),
                      child: Text(
                        "${animeQuotes.quote}",
                        style: Theme.of(context).textTheme.headline3,
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  width: 220,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SelectableText("~ ${animeQuotes.character}"),
                      Text(
                        "${animeQuotes.anime}",
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
