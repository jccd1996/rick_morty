import 'package:models/results_episodes.dart';

import 'info.dart';

class EpisodesResponse {
  Info? info;
  List<ResultsEpisodes>? results;

  EpisodesResponse({this.info, this.results});

  EpisodesResponse.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = <ResultsEpisodes>[];
      json['results'].forEach((v) {
        results!.add(new ResultsEpisodes.fromJson(v));
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
}
