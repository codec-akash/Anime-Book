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
}
