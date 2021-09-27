import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mulyric/modals/track_list_modal.dart';
import 'package:mulyric/utils/apis.dart';

import 'description_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TrackListModal> trackListModalData = [];
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trackListModalData = [];
    fetchSongsApiMethod();
  }

  fetchSongsApiMethod() async {
    setState(() {
      loading = true;
    });
    List<TrackListModal> trackListModal = [];
    trackListModal = await API().fetchMusicListDataAPI();
    print(trackListModal);
    setState(() {
      trackListModalData = trackListModal;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mulyric"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: trackListModalData
                    .map(
                      (trackItem) => Card(
                        child: ListTile(
                          title: Text(trackItem.trackName.toString()),
                          subtitle: Text(trackItem.artistName.toString()),
                          leading: Icon(Icons.thumb_up),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DescriptionPage(
                                    trackListModalDataObject:
                                        trackListModalData,
                                    trackName: trackItem.trackName,
                                    albumName: trackItem.albumName,
                                    artist: trackItem.artistName,
                                    explicit: trackItem.explicit,
                                    rating: trackItem.trackRating,
                                    trackId: trackItem.trackId,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}
