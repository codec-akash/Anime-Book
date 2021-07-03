import 'package:animebook/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class QuotesOptions extends StatefulWidget {
  final Widget quotesCard;
  const QuotesOptions({Key? key, required this.quotesCard}) : super(key: key);

  @override
  _QuotesOptionsState createState() => _QuotesOptionsState();
}

class _QuotesOptionsState extends State<QuotesOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes Options"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40.0),
            widget.quotesCard,
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text("Share this on Whatsapp"),
              onPressed: () {
                Share.share("Share this quote with : ");
              },
            ),
          ],
        ),
      ),
    );
  }
}
