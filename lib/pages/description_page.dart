import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mulyric/modals/trach_detail_lyrics_modal.dart';
import 'package:mulyric/modals/track_list_modal.dart';
import 'package:mulyric/utils/apis.dart';

class DescriptionPage extends StatefulWidget {
  late final List<TrackListModal>? trackListModalDataObject;
  final int? trackId;
  final String? trackName;
  final String? artist;
  final String? albumName;
  final int? explicit;
  final int? rating;
  DescriptionPage({
    this.trackListModalDataObject,
    this.trackId,
    this.trackName,
    this.albumName,
    this.explicit,
    this.artist,
    this.rating,
  });
  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  List<TrackDetailLyricsModal> trackListModalData = [];
  bool loading = true;

  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSongsLyricsApiMethod();
    loading = true;
    print("\n\n \n\n trackListModalData :: => $trackListModalData \n\n \n\n");
  }

  fetchSongsLyricsApiMethod() async {
    List<TrackDetailLyricsModal> trackLyricsModal = [];
    trackLyricsModal = await API().fetchMusicDetailDataAPI();
    print(trackLyricsModal);
    if (trackLyricsModal.length != 0) {
      setState(() {
        trackListModalData = trackLyricsModal;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lyrics"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: trackListModalData.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitleWidget(title: "Name"),
                    buildTextDataWidget(text: widget.trackName.toString()),
                    SizedBox(height: 16),
                    buildTitleWidget(title: "Artist"),
                    buildTextDataWidget(text: widget.artist.toString()),
                    SizedBox(height: 16),
                    buildTitleWidget(title: "Album Name"),
                    buildTextDataWidget(text: widget.albumName.toString()),
                    SizedBox(height: 16),
                    buildTitleWidget(title: "Explicit"),
                    buildTextDataWidget(
                      text: widget.explicit == 0 ? "False" : "True",
                    ),
                    SizedBox(height: 16),
                    buildTitleWidget(title: "Rating"),
                    buildTextDataWidget(text: widget.rating.toString()),
                    SizedBox(height: 16),
                    buildTitleWidget(title: "Lyrics"),
                    SizedBox(height: 6),
                    buildTextDataWidget(
                      text: trackListModalData[index].lyricsBody.toString(),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Text buildTextDataWidget({required String text}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black.withOpacity(0.6),
      ),
    );
  }

  Text buildTitleWidget({required String title}) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    );
  }
}
