import 'package:animebook/models/anime_quote_model.dart';
import 'package:animebook/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class QuotesOptions extends StatefulWidget {
  final AnimeQuotes animeQuotes;
  const QuotesOptions({Key? key, required this.animeQuotes}) : super(key: key);

  @override
  _QuotesOptionsState createState() => _QuotesOptionsState();
}

class _QuotesOptionsState extends State<QuotesOptions>
    with SingleTickerProviderStateMixin {
  final ScreenshotController screenshotController = ScreenshotController();
  late AnimationController flashAnimation;

  @override
  void initState() {
    flashAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  captureAndShare() async {
    await flashAnimation.forward();
    flashAnimation.reset();

    const imageName = 'anime.png';
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    // String imageName = '${widget.animeQuotes.anime} quote';
    var imp = (await getTemporaryDirectory()).absolute.path;
    var path = await screenshotController.captureAndSave(
      imp,
      fileName: imageName,
      pixelRatio: pixelRatio,
      delay: Duration(seconds: 1),
    );
    if (path != null) {
      await Share.shareFiles([path], subject: "imageName");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.animeQuotes.anime}"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            ShareableQuoteCard(animeQuotes: widget.animeQuotes),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                child: Container(
                  child: Text("Share this"),
                ),
                onPressed: () {
                  String sendableQuotes = Global.sendQuotes(widget.animeQuotes);
                  Share.share("$sendableQuotes");
                },
              ),
            ),
            // Row(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.symmetric(horizontal: 15.0),
            //       width: MediaQuery.of(context).size.width * 0.5,
            //       child: ElevatedButton(
            //         child: Container(
            //           child: Text("Share this"),
            //         ),
            //         onPressed: () {
            //           String sendableQuotes =
            //               Global.sendQuotes(widget.animeQuotes);
            //           Share.share("$sendableQuotes");
            //         },
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsets.symmetric(horizontal: 15.0),
            //       width: MediaQuery.of(context).size.width * 0.5,
            //       child: ElevatedButton(
            //         child: Container(
            //           child: Text("Share Screenshot"),
            //         ),
            //         onPressed: () {
            //           captureAndShare();
            //         },
            //       ),
            //     ),
            //   ],
            // ),
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
              child: Center(
                child: SingleChildScrollView(
                  child: Text(
                    "${animeQuotes.quote}",
                    style: Theme.of(context).textTheme.headline4,
                    softWrap: true,
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
