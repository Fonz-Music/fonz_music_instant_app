import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:url_launcher/url_launcher.dart';


class BuyACoasterButton extends StatefulWidget {
  @override
  _BuyACoasterButtonState createState() => _BuyACoasterButtonState();
}

class _BuyACoasterButtonState extends State<BuyACoasterButton> {
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
                  image: AssetImage("assets/fonzIcons/coasterIconAmber.png"),
                  height: 30,
                  width: 30,
                ),
              ),
              Text(
                "buy a coaster",
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGFIVE,
                  color: determineColorThemeTextInverse(),
                ),
              ),
            ],
          ),
        ),
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.rect(),
            color: determineColorThemeBackground()
        ),
        onPressed: () async {
          var url = "https://fonzmusic.com/buy";
          if (await canLaunch(url))
          await launch(url);
          else
          // can't launch url, there is some error
          throw "Could not launch $url";
          log("pressed sign out");
          FirebaseAnalytics().logEvent(name: "userOpenedBuyCoaster", parameters: {'string': "user"});
        },

      ),
    );
  }
}