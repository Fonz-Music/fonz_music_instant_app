import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_instant_app/ApiFunctions/SpotifyEndpoints/SpotifySuggestionsApi.dart';
import 'package:fonz_music_instant_app/GlobalComponents/GlobalFunctions/SpotifyResultsFunctions.dart';
import 'package:fonz_music_instant_app/GlobalComponents/GlobalSessionVariables.dart';
import 'package:fonz_music_instant_app/GlobalComponents/Objects/Playlist.dart';
import 'package:fonz_music_instant_app/SearchTab/SearchPageWidgets/SearchSuggestionsWidgets/TopPlaylistsWidgets/TopPlaylistsView.dart';

import '../../../../main.dart';

class TopPlaylistsFutureBuilder extends StatefulWidget {
  @override
  _TopPlaylistsFutureBuilderState createState() => _TopPlaylistsFutureBuilderState();
}

class _TopPlaylistsFutureBuilderState extends State<TopPlaylistsFutureBuilder> {

  Future<List<Playlist>> getTopPlaylists() async {
    if (updateTopPlaylists) {
      log("going to get top songs");
      // change to guest depending
      if (userAttributes.getConnectedToSpotify() && userAttributes.getUserSessionId() != "") {
        log("user has session ");
        final fetchedTopPlaylists = await SpotifySuggestionsApi
            .getGuestTopPlaylists(userAttributes.getUserSessionId());
        log("got top songs");
        var playlists = fetchedTopPlaylists["body"];
        log("got items from json");
        topPlaylists = playlistsJsonToList(playlists);
      }
      // get top Fonz songs
      else {
        log("using host creds");
        final fetchedTopPlaylists = await SpotifySuggestionsApi
            .getGuestTopPlaylists(hostSessionIdGlobal);

        // if (fetchedTopPlaylists["statusCode"] == 200) {
        //   log("can acc get host creds");
        //   // log("number of songs is" + fetchedTopSongs["body"].toString());
          var playlists = fetchedTopPlaylists["body"];
          log("got items from json");
          topPlaylists = playlistsJsonToList(playlists);
        // }
        // else {
        //   log("using temp tracks");
        //   topPlaylists = tempPlaylists;
        // }
      }
      updateTopPlaylists = false;
    } else {
      log("does not need top playlists");
    }

    return topPlaylists;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      child: FutureBuilder(
          future: getTopPlaylists(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Container(
                // child: TopSongsView(),
              );
            }
            else if (snapshot.data != null && topPlaylists.length > 0) {
              log("data is " + snapshot.data.toString());
              return
                TopPlaylistsView(playlists: snapshot.data);

            }
            else {
              return
                TopPlaylistsView(playlists: tempPlaylists);
            }

          }
      ),
    );
  }
}
