import 'package:animebook/models/anime_quote_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class Global {
  static BorderRadius borderRadius = BorderRadius.circular(10.0);
  static BorderRadius borderRadius20 = BorderRadius.circular(20.0);

  static const String defaultText =
      "Awww Man, Your Internet Sucks \n \t\t\t\t\t\t\t\t ~Creator of this app \n \t\t\t\t\t\t\t\t Real life anime";

  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  static sendWhatsapp(String phone, String text) async {
    var uri = "https://wa.me/$phone?text=$text";
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw "Not able to send sms";
    }
  }

  static String sendQuotes(AnimeQuotes animeQuotes) {
    String msg = '';
    msg = animeQuotes.quote +
        "  - character" +
        animeQuotes.character +
        " From Anime -" +
        animeQuotes.character;
    return msg;
  }
}
