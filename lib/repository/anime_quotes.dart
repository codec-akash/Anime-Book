import 'package:animebook/models/anime_quote_model.dart';
import 'package:animebook/networking/api_provider.dart';

class QuotesApi {
  Future<List<AnimeQuotes>> getAnimeQuotes() async {
    final endPoint = "/quotes";
    var data = await ApiProvider().getCall(endPoint);
    List<AnimeQuotes> animeQuotes;
    if (data['error'] != null) {
      animeQuotes = [];
      throw "error Occured";
    } else {
      animeQuotes = (data['result'] as List)
          .map((quote) => AnimeQuotes.fromJson(quote))
          .toList();
    }
    return animeQuotes;
  }

  Future<List<String>> getAnimeList() async {
    List<String> animeList = [];
    final endPoint = "/available/anime";
    try {
      var data = await ApiProvider().getCall(endPoint);
      print(data['result']);
      animeList = data['result'].cast<String>();
      // if (data['error'] != null) {
      //   throw "Error";
      // }
    } catch (e) {
      print("Error -$e");
      throw "Error";
    }
    return animeList;
  }

  Future<List<AnimeQuotes>> getSpecificAnimeQuotes(String animeName) async {
    List<AnimeQuotes> animeQuotes = [];
    final endPoint = "/quotes/anime?title=$animeName";
    try {
      var data = await ApiProvider().getCall(endPoint);
      animeQuotes = (data['result'] as List)
          .map((quotes) => AnimeQuotes.fromJson(quotes))
          .toList();
    } catch (e) {
      throw "Error occured";
    }
    return animeQuotes;
  }
}
