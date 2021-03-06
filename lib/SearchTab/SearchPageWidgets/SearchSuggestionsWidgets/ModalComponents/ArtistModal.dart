import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_instant_app/ApiFunctions/SpotifyEndpoints/SpotifySuggestionsApi.dart';
import 'package:fonz_music_instant_app/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_instant_app/GlobalComponents/GlobalFunctions/SpotifyResultsFunctions.dart';
import 'package:fonz_music_instant_app/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_instant_app/GlobalComponents/Objects/Artist.dart';

import 'package:fonz_music_instant_app/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_instant_app/SearchTab/SearchPageWidgets/TrackButton.dart';

import '../../../SearchPage.dart';
import '../DetermineQueueSongResps.dart';
import 'ShowTracksOrPromptNfc.dart';

class ArtistModal extends StatefulWidget {

  ArtistModal({Key key, this.givenArtist}) : super(key: key);
  Artist givenArtist;

  @override
  _ArtistModalState createState() => _ArtistModalState();
}

class _ArtistModalState extends State<ArtistModal> {



  Future<List<Track>> getTracksByArtistId() async {

    if (updateTracksFromArtist) {
      log("using host creds");
      final fetchedTracks = await SpotifySuggestionsApi
          .getTracksByArtist(hostSessionIdGlobal, widget.givenArtist.artistId);

      if (fetchedTracks["statusCode"] == 200) {
        log("can acc get host creds");
        // log("number of songs is" + fetchedTopSongs["body"].toString());
        var tracks = fetchedTracks["body"];
        log("got items from json");
        tracksFromArtist = tracksJsonToList(tracks);
      }
      else {
        log("using temp tracks");
        tracksFromArtist = tempTracks;
      }
    }
    else {
      log("does not need more tracks from artist");
    }

    return tracksFromArtist;
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return
      // ValueListenableBuilder<String>(
      //     valueListenable: responseCodeFromQueue,
      //     builder:  (context, value, child) {
      //       return
      //         Stack(
      //           children: [
                  Container(
                    height: height * 0.9,
                    color: determineColorThemeBackground(),
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            color: AMBER,
                            height: height * 0.15,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  // *---------------Use variable taken from Library selection for album url-----*
                                  child: ClipRRect(

                                    borderRadius: BorderRadius.circular(CORNERRADIUSBUTTON),
                                    child: Image.network("${widget.givenArtist.artistImage}",
                                      height: height * 0.1,
                                      // width: height * 0.1,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Spacer(),
                                    SizedBox(
                                      width: width * 0.6,
                                      child: Text(
                                        // *---------------Use variable taken from Library selection for artist--------*
                                        // removes the brackets from the string
                                        "${widget.givenArtist.artistName}",
                                        style: TextStyle(
                                          fontFamily: FONZFONTTWO,
                                          fontSize: HEADINGFOUR,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.6,
                                      child: Text(
                                        // *---------------Use variable taken from Library selection for artist--------*
                                        // removes the brackets from the string
                                        "artist",
                                        style: TextStyle(
                                          fontFamily: FONZFONTONE,
                                          fontSize: HEADINGFIVE,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                )
                              ],
                            )
                        ),
                        // ValueListenableBuilder<bool>(
                        //     valueListenable: pressedToLaunchQueueNfc,
                        //     builder: (context, value, child) {
                        //       return
                                FutureBuilder(
                                    future: getTracksByArtistId(),
                                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState != ConnectionState.done) {
                                        return Container(
                                          // child: TopSongsView(),
                                        );
                                      }
                                      else if (snapshot.data != null) {
                                        log("data is " + snapshot.data.toString());
                                        return
                                          ShowTracksOrPromptNfc(givenTracks: snapshot.data);

                                      }
                                      else {
                                        return
                                          ShowTracksOrPromptNfc(givenTracks: tempTracks);
                                      }

                                    }

                      //           );
                      //       }
                        ),
                      ],
                    ),
                  // ),
          //         Column(
          //           children: [
          //             DisplayQueueSongResponses(context),
          //             Spacer()
          //           ],
          //         ),
          //       ],
          //     );
          // }
      );
  }
}
