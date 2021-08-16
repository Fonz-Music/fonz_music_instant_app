import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/GuestApi/GuestSpotifyApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/CoreUserAttributes.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/HostTab/TapYourPhoneLilac.dart';
import 'package:fonz_music_flutter/MainTabs/SearchTab.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/QueueSongResponses/QueueFailNotSameCoaster.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/QueueSongResponses/QueueSongFail.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/QueueSongResponses/QueueSongSuccess.dart';
import 'package:fonz_music_flutter/SearchTab/SearchPageWidgets/QueueSongResponses/QueuedButDelayed.dart';

import 'SearchPageWidgets/ActiveSongWidgets/ActiveSongView.dart';
import 'SearchPageWidgets/SearchBarWidgets/SearchBar.dart';
import 'SearchPageWidgets/SearchBarWidgets/SearchResultsView.dart';
import 'SearchPageWidgets/SearchSuggestionsWidgets/DetermineQueueSongResps.dart';
import 'SearchPageWidgets/SearchSuggestionsWidgets/SongSuggestionsView.dart';

var pressedToLaunchQueueNfc = ValueNotifier<bool>(false);
var responseCodeFromQueue = ValueNotifier<String>("");
String songAddedToQueue = "";

class SearchPage extends StatefulWidget {

  SearchPage({Key key, this.controller, this.notifyParent}) : super(key: key);
  PageController controller;
  Function notifyParent;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    refresh() {
      setState(() {
        log("resetting search page");
      });
    }

    return SingleChildScrollView(
      child:
      ValueListenableBuilder<String>(
          valueListenable: responseCodeFromQueue,
          builder:  (context, value, child) {
            return
              Stack(
                children: [

                  Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                              child: new Text(
                                "search",
                                style: TextStyle(
                                  fontFamily: FONZFONTTWO,
                                  fontSize: HEADINGTHREE,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                widget.controller.animateToPage(0,
                                    duration: Duration(seconds: 1), curve: Curves.easeInOutCirc);

                                connectedToAHost = false;
                                widget.notifyParent();
                              },
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                                child: new Text(
                                  "leave party",
                                  style: TextStyle(
                                    fontFamily: FONZFONTTWO,
                                    fontSize: HEADINGFIVE,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          ],
                        ),


                        ValueListenableBuilder<bool>(
                            valueListenable: pressedToLaunchQueueNfc,
                            builder: (context, value, child) {
                              return
                                WaitForNfcToQueue(refresh);
                            }
                        ),


                      ]
                  ),
                  DisplayQueueSongResponses(context),
                ],
              );
          }
      ),
    );
  }



  Widget WaitForNfcToQueue(refresh) {
    if (!pressedToLaunchQueueNfc.value) {

      return
        Column(
          children: [
            SearchBar(notifyParent: refresh),
            Stack(
              children: [
                Column(
                  children: [

                    ActiveSongView(),
                    SongSuggestionsView(notifyParent: widget.notifyParent,)
                  ],
                ),
                DetermineIfResultsAreShown()
              ],
            ),
          ],
        );
    }
    else return Container(
      // height: 0,
      child: TapYourPhoneLilac(),
    );
  }



  Widget DetermineIfResultsAreShown() {
    if (searchingSong) {

      return
        ValueListenableBuilder<String>(
          valueListenable: searchSong,
          builder:  (context, value, child) {
            return
              SearchResultsView();
          }
        );
    }
    else return Container(height: 0,);
  }

}
