import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Playlist.dart';
import 'package:fonz_music_flutter/GlobalComponents/Objects/Track.dart';
import 'package:fonz_music_flutter/HostTab/TapYourPhoneLilac.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/TrackButton.dart';

import '../../../SearchPage.dart';
import '../DetermineQueueSongResps.dart';

class PlaylistTrackModal extends StatefulWidget {

  PlaylistTrackModal({Key key, this.givenPlaylist}) : super(key: key);
  Playlist givenPlaylist;

  @override
  _PlaylistTrackModalState createState() => _PlaylistTrackModalState();
}

class _PlaylistTrackModalState extends State<PlaylistTrackModal> {

  var tempTracks = [
    Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
    Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
    Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
    Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
    Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
    Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
    Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
    Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
    Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
    Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
    Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
    Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
    Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
    Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
    Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
    Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),
    Track("Boyfriend", [" Big Time Rush"], "1rKBOL9kJfX1Y4C3QaOvRH", "https://i.scdn.co/image/ab67616d0000b27350acd1f66ebd5b84630c7129"),
    Track.withUrl("Is It True", ["Tame Impala"], "6RZmhpvukfyeSURhf4kZ0d", "https://i.scdn.co/image/ab67616d0000b27358267bd34420a00d5cf83a49", "https://open.spotify.com/track/6RZmhpvukfyeSURhf4kZ0d"),
    Track.withUrl("The Spirit Of Radio", ["Rush"], "4e9hUiLsN4mx61ARosFi7p", "https://i.scdn.co/image/ab67616d0000b27306c0d7ebcabad0c39b566983", "https://open.spotify.com/track/4e9hUiLsN4mx61ARosFi7p"),
    Track.withUrl("Limelight", ["Rush"], "0K6yUnIKNsFtfIpTgGtcHm", "https://i.scdn.co/image/ab67616d0000b27372833c1ae3343cbfb4617073", "https://open.spotify.com/track/0K6yUnIKNsFtfIpTgGtcHm"),

  ];


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return
      ValueListenableBuilder<String>(
          valueListenable: responseCodeFromQueue,
          builder:  (context, value, child) {
          return
            Stack(
              children: [
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
                              child: Image.network("${widget.givenPlaylist.playlistImage}",
                                height: height * 0.1,
                                // width: height * 0.1,
                                // width: 120,
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
                                  "${widget.givenPlaylist.playlistName}",
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
                                  "${widget.givenPlaylist.amountOfTracks.toString()} tracks",
                                  style: TextStyle(
                                    fontFamily: FONZFONTONE,
                                    fontSize: HEADINGFIVE,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Spacer()
                            ],
                          )
                        ],
                      )
                    ),
                    ValueListenableBuilder<bool>(
                        valueListenable: pressedToLaunchQueueNfc,
                        builder: (context, value, child) {
                          return
                            ShowPlaylistSongsOrPromptNfc();
                        }
                    ),

                  ],
                ),
              ),
                Column(
                  children: [
                    DisplayQueueSongResponses(context),
                    Spacer()
                  ],
                ),
              ],
            );
          }
      );
  }

  Widget ShowPlaylistSongsOrPromptNfc() {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    if (!pressedToLaunchQueueNfc.value) {

      return
        Container(

          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: new Text(
                      "songs",
                      style: TextStyle(
                        fontFamily: FONZFONTTWO,
                        fontSize: HEADINGFIVE,
                        color: determineColorThemeTextInverse(),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Spacer()
                ],
              ),
              SizedBox(
                height: height * 0.65,
                child: Column(
                  children: [
                    Flexible(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: tempTracks.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TrackButton(givenTrack: tempTracks[index],);
                        },
                        separatorBuilder: (BuildContext context,
                            int index) => const Divider(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    }
    else return Container(
      // height: 0,
      child: TapYourPhoneLilac(),
    );
  }

}
