import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_instant_app/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_instant_app/SettingsTab/SettingsFields/ManageSpotifyField.dart';
import 'package:fonz_music_instant_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// String spotifyId  = "spotify account";

class ManageSpotifyButton extends StatefulWidget {

  ManageSpotifyButton({Key key,  this.notifyParent}) : super(key: key);
  Function notifyParent;

  @override
  _ManageSpotifyButtonState createState() => _ManageSpotifyButtonState();
}

class _ManageSpotifyButtonState extends State<ManageSpotifyButton> {



  // @override
  // void initState() {
  //   super.initState();
  //   // get sessionId from local storage
  //   SharedPreferences.getInstance().then((prefs) {
  //     var spotifyFromStorage = prefs.getString("spotifyDisplayName");
  //     if (spotifyFromStorage != null && spotifyFromStorage != "") {
  //
  //       spotifyId = spotifyFromStorage;
  //     }
  //   } );
  //
  //
  // }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: NeumorphicButton(
        child: Container(
          width: width * 0.8,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Image(
                  image: AssetImage("assets/fonzIcons/spotifyIconAmber.png"),
                  height: 30,
                  width: 30,
                ),
              ),
              Text(
                userAttributes.getSpotifyId(),
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGSIX,
                  color: determineColorThemeTextInverse(),
                ),
              ),
            ],
          ),
        ),
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.rect(),
            color: determineColorThemeBackground(),
            shadowDarkColor: determineLightShadowRoundButton(),
            shadowLightColor: determineLightShadowRoundButton()
        ),
        onPressed: () async {

          await showDialog(
              context: context,
              builder: (popupContext) {
                return ManageSpotifyField(popupContext: popupContext, notifyParent: widget.notifyParent);
              }
          );
          // widget.notifyParent();
        },
        // onPressed: () {
        //   log("pressed sign out");
        //   FirebaseAnalytics().logEvent(name: "userOpenedManageSpotify", parameters: {'string': "user"});
        // },

      ),
    );
  }
}
