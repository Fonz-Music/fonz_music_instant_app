

import 'dart:developer';

import 'package:fonz_music_instant_app/ApiFunctions/HostApi/HostProvidersApi.dart';
import 'package:fonz_music_instant_app/ApiFunctions/HostApi/HostSessionsApi.dart';
import 'package:fonz_music_instant_app/ApiFunctions/SpotifyEndpoints/SpotifySignInApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

connectSpotify() async {
  log("connecting spot");
  // fetch spotify sign in url
  var url = await SpotifySignInApi.getSpotifyAuthUrl();
  
  log("url is " + url);
  // can use launch url
  if (await canLaunch(url))
    // if so, launch
    await launch(url);
  else
    // can't launch url, there is some error
    throw "Could not launch $url";
  
  // // on return
  // // fetch all sessions, stores sessionId from session #0 or
  // // creates a new one
  // var sessions = await HostSessionsApi.getAllSessions();
  // // fetch all providers
  // var providers = await HostProvidersApi.getMusicProviders();
  // log(providers["body"].toString());
  // // sets providerId
  // final providerId = providers["body"][0]["providerId"];
  // // sessionId stored in local storage
  // SharedPreferences localPreferences = await SharedPreferences.getInstance();
  // // sets sessionId
  // final sessionId = await localPreferences.getString("userAccountSessionId");
  // log("sessionId is " + sessionId);
  // var updateSessionWithProviderId = await HostSessionsApi.updateSessionWithProviderId(sessionId, providerId);
  // log("status code of updating is " + updateSessionWithProviderId["statusCode"].toString());
}

linkSpotifyOnCallback() async {
  // on return
  // fetch all sessions, stores sessionId from session #0 or
  // creates a new one
  var sessions = await HostSessionsApi.getAllSessions();
  // fetch all providers
  var providers = await HostProvidersApi.getMusicProviders();
  log(providers["body"].toString());
  // sets providerId
  final providerId = providers["body"][0]["providerId"];
  // sessionId stored in local storage
  SharedPreferences localPreferences = await SharedPreferences.getInstance();
  // sets sessionId
  final sessionId = await localPreferences.getString("userAccountSessionId");
  log("sessionId is " + sessionId);
  var updateSessionWithProviderId = await HostSessionsApi.updateSessionWithProviderId(sessionId, providerId);
  log("status code of updating is " + updateSessionWithProviderId["statusCode"].toString());
  if (updateSessionWithProviderId["statusCode"] == 200) {
    userAttributes.setConnectedToSpotify(true);
  }
  userAttributes.determineIfUserConnectedToSpotify();

}