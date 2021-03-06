import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_instant_app/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_instant_app/SettingsTab/SettingsFields/SignOutField.dart';




class SignOutButton extends StatefulWidget {

  SignOutButton({Key key,  this.notifyParent}) : super(key: key);
  Function notifyParent;

  @override
  _SignOutButtonState createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
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
                  image: AssetImage("assets/fonzIcons/signOutIcon.png"),
                  height: 30,
                  width: 30,
                ),
              ),
              Text(
                "sign out",
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
                return SignOutField(popupContext: popupContext, notifyParent: widget.notifyParent);
              }
          );
          FirebaseAnalytics().logEvent(name: "userSignedOut", parameters: {'string': "user","device":"android"});
          // widget.notifyParent();
        },
        // onPressed: () {
        //   log("pressed sign out");

        // },

      ),
    );
  }
}
