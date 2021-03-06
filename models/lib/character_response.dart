import 'package:models/base_model.dart';

import 'info.dart';
import 'result_character.dart';

class CharacterResponse with BaseModel {
  Info? info;
  List<ResultsCharacter>? results;

  CharacterResponse({this.info, this.results});

  CharacterResponse.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = <ResultsCharacter>[];
      json['results'].forEach((v) {
        results!.add(new ResultsCharacter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String get id => '1';
}
