

import 'dart:developer';

import 'package:fonz_music_instant_app/ApiFunctions/GuestApi/GuestSpotifyApi.dart';
import 'package:fonz_music_instant_app/ApiFunctions/HostApi/CoasterManagementApi.dart';
import 'package:fonz_music_instant_app/ApiFunctions/HostApi/HostProvidersApi.dart';
import 'package:fonz_music_instant_app/ApiFunctions/HostApi/HostSessionsApi.dart';
import 'package:fonz_music_instant_app/ApiFunctions/HostApi/HostSpotifyApi.dart';
import 'package:fonz_music_instant_app/ApiFunctions/UserEndpoints/UserApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';



class CoreUserAttributes {
  bool _connectedToSpotify = false;
  bool _hasConnectedCoasters = false;
  bool _hasAccount = false;
  String _userSpotifyId = "spotify account";
  String _userSpotifyEmail = "";
  bool _agreedToEmail = false;
  bool _agreedConsent = false;
  String _userId = "";
  String _userDisplayName = "";
  String _userSessionId = "";

  // bool throwCreateAccountPopup = false;

  setAttributes() async {
    log("setting attributes");
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    final spotifyBoolFromStorage = localPreferences.getBool("_connectedToSpotify");
    if (spotifyBoolFromStorage != null) {
      _connectedToSpotify = spotifyBoolFromStorage;
    }
    final coastersBoolFromStorage = localPreferences.getBool("_hasConnectedCoasters");
    if (coastersBoolFromStorage != null) {
      _hasConnectedCoasters = coastersBoolFromStorage;
    }
    final accountBoolFromStorage = localPreferences.getBool("_hasAccount");
    if (accountBoolFromStorage != null) {
      _hasAccount = accountBoolFromStorage;
    }
    final spotifyIdFromStorage = localPreferences.getString("spotifyDisplayName");
    if (spotifyIdFromStorage != null) {
      _userSpotifyId = spotifyIdFromStorage;
    }

    final spotifyEmailFromStorage = localPreferences.getString("spotifyEmail");
    if (spotifyEmailFromStorage != null) {
      _userSpotifyEmail = spotifyEmailFromStorage;
    }

    final agreedEmailFromStorage = localPreferences.getBool("agreedToEmail");
    if (agreedEmailFromStorage != null) {
      _agreedToEmail = agreedEmailFromStorage;
    }

    final agreedConsentFromStorage = localPreferences.getBool("agreedConsent");
    if (agreedConsentFromStorage != null) {
      _agreedConsent = agreedConsentFromStorage;
    }

    final userIdFromStorage = localPreferences.getString("userId");
    if (userIdFromStorage != null) {
      _userId = userIdFromStorage;
    }

    final userDisplayNameFromStorage = localPreferences.getString("userDisplayName");
    if (userDisplayNameFromStorage != null) {
      _userDisplayName = userDisplayNameFromStorage;
    }

    final userSessionIdFromStorage = localPreferences.getString("userAccountSessionId");
    if (userSessionIdFromStorage != null) {
      _userSessionId = userSessionIdFromStorage;
    }

    log("spot is " + _connectedToSpotify.toString());
    log("coasters is " + _hasConnectedCoasters.toString());
    log("account is " + _hasAccount.toString());
  }

  determineAllUserAttributesAfterSignIn() async {
    await determineIfUserConnectedToSpotify();
    await determineIfUserHasCoasters();
    await UserApi.getUserAccount();
    await determineIfUserHasSessionAndSetSessionId();
    await setAttributes();
  }

  deleteAttributesAfterSignOut() async {
    await setHasAccount(false);
    await setConnectedToSpotify(false);
    await setHasConnectedCoasters(false);
    await setAgreedEmail(false);
    await setUserDisplayName("");
    await setUserId("");
    await setUserSessionId("");



  }

  bool getHasAccount() {
    return _hasAccount;
  }
  setHasAccount(bool boolie) async {
    this._hasAccount = boolie;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setBool("_hasAccount", boolie);

  }

  bool getHasConnectedCoasters() {
    return _hasConnectedCoasters;
  }
  setHasConnectedCoasters(bool boolie) async {
    this._hasConnectedCoasters = boolie;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setBool("_hasConnectedCoasters", boolie);
  }
  determineIfUserHasCoasters() async {
    // get music providers

    var coasters = await CoasterManagementApi.getOwnedCoasters();

    // checks how many providers & updates accordingly
    if (coasters["body"]["quantity"] > 0) {
      setHasConnectedCoasters(true);
    }
    else {
      setHasConnectedCoasters(false);
    }
  }

  bool getConnectedToSpotify() {
    return _connectedToSpotify;
  }
  setConnectedToSpotify(bool boolie) async {
    this._connectedToSpotify = boolie;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setBool("_connectedToSpotify", boolie);
  }
  determineIfUserConnectedToSpotify() async {
    // get music providers

    var musicProviders = await HostProvidersApi.getMusicProviders();

    // checks how many providers & updates accordingly
    if (musicProviders["body"].length > 0 && musicProviders["body"][0]["providerId"] != "") {
      log("user has providers");
      setConnectedToSpotify(true);
      userConnectedToSpotify.value = true;
    }
    else {
      log("user does NOT have providers");
      setConnectedToSpotify(false);
    }
  }

  String getSpotifyId() {
    return _userSpotifyId;
  }

  String getSpotifyIdForSignIn() {
    if (_userSpotifyId == "spotify account") return "";
    else return _userSpotifyId;
  }

  String getSpotifyEmail() {
    return _userSpotifyEmail;
  }

  // agree email
  bool getAgreedEmail() {
    return _agreedToEmail;
  }
  setAgreedEmail(bool boolie) async {
    this._agreedToEmail = boolie;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setBool("agreedToEmail", boolie);

  }

  // agree consent
  bool getAgreedConsent() {
    return _agreedConsent;
  }
  setAgreedConsent(bool boolie) async {
    this._agreedConsent = boolie;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setBool("agreedConsent", boolie);

  }

  // user id
  String getUserId() {
    return _userId;
  }
  setUserId(String newId) async {
    this._userId = newId;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setString("userId", newId);

  }

  // user display name
  String getUserDisplayName() {
    return _userDisplayName;
  }
  setUserDisplayName(String newName) async {
    this._userDisplayName = newName;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setString("userDisplayName", newName);

  }

  // user sessionId
  String getUserSessionId() {
    return _userSessionId;
  }
  setUserSessionId(String newId) async {
    this._userSessionId = newId;
    // Create local preferences
    SharedPreferences localPreferences = await SharedPreferences.getInstance();
    // store in preferences
    localPreferences.setString("userAccountSessionId", newId);

  }
  determineIfUserHasSessionAndSetSessionId() async {
    await HostSessionsApi.getAllSessions();
  }
}