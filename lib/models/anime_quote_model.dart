import 'package:equatable/equatable.dart';

class AnimeQuotes extends Equatable {
  String? anime;
  String? character;
  String? quote;

  AnimeQuotes({this.anime, this.character, this.quote});

  AnimeQuotes.fromJson(Map<String, dynamic> json) {
    anime = json['anime'];
    character = json['character'];
    quote = json['quote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anime'] = this.anime;
    data['character'] = this.character;
    data['quote'] = this.quote;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [anime, character, quote];
}
