import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mulyric/modals/trach_detail_lyrics_modal.dart';
import 'package:mulyric/modals/track_list_modal.dart';

class API {
  static final BASE_URL = "https://api.musixmatch.com/ws/1.1";

  static final FETCH_SONGS_DATA_URL =
      "$BASE_URL/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";

  Uri fetchSongsDataUri = Uri.parse(FETCH_SONGS_DATA_URL);

  static final FETCH_SONGS_DETAILS_URL =
      "$BASE_URL/track.lyrics.get?track_id=223550307&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";

  Uri fetchSongsDetailUri = Uri.parse(FETCH_SONGS_DETAILS_URL);

  Future<List<TrackListModal>> fetchMusicListDataAPI() async {
    try {
      http.Response response = await http.get(fetchSongsDataUri);

      var responseBody = jsonDecode(response.body);
      responseBody = responseBody["message"];
      responseBody = responseBody["body"];

      var trackList = responseBody["track_list"];

      List<TrackListModal> trackListData = [];
      for (var tmp in trackList) {
        TrackListModal musicListGenre = TrackListModal.fromJson(tmp["track"]);
        trackListData.add(musicListGenre);
      }
      print('\n\n \n\n TMP DATA DATA: ${trackListData}');

      return trackListData;
    } catch (e) {
      print('\n\n TrackListModalPrimaryMusicListGenre: $e \n\n');
      return [];
    }
  }

  Future<List<TrackDetailLyricsModal>> fetchMusicDetailDataAPI() async {
    try {
      http.Response response = await http.get(fetchSongsDetailUri);

      var responseBody = jsonDecode(response.body);
      responseBody = responseBody["message"];
      responseBody = responseBody["body"];

      List<TrackDetailLyricsModal> trackListData = [];

      TrackDetailLyricsModal musicListGenre =
          TrackDetailLyricsModal.fromJson(responseBody["lyrics"]);
      print('\n\n \n\n TMP DATA DATA2: $musicListGenre \n\n \n\n');
      trackListData.add(musicListGenre);

      return trackListData;
    } catch (e) {
      print('\n\n fetchMusicDetailDataAPI: $e \n\n');
      return [];
    }
  }
}
