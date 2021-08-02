import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fonz_music_flutter/ApiFunctions/UserEndpoints/AuthApi.dart';

Future<String> getJWTAndCheckIfExpired() async {

  // Create storage
  final storage = new FlutterSecureStorage();
  // init isValid bool
  var isValid = false;

  // fetch accessToken from keystore
  String accessToken = await storage.read(key: "accessToken");
  // check its not empty
  if (accessToken != null && accessToken != "") {
    log("accessToken is " + accessToken);
    isValid = checkIfTokenValid(accessToken);
    print("accessToken valid: " + isValid.toString());
  }
  // check if its valid OR if accessToken is nil
  if (!isValid) {
    // fetch accessToken from keystore
    String refreshToken = await storage.read(key: "refreshToken");
    log("refreshToken is " + refreshToken);
    // check if user already has account (check for refresh + access)
    if (refreshToken != null && refreshToken != "" && accessToken != null && accessToken != "") {
        String userId = getUserIdFromAccessToken(accessToken);

        print("refreshing token");
        // refresh token endpoint
      var refreshEndpointResp = await AuthApi.refreshAccessToken(userId, refreshToken);
      accessToken = refreshEndpointResp["body"].accessToken;

    }
    // if no account, create an anon account
    else {
      print("creating anon acc");
      log("creating acc anon");
      // create anon account endpoint
      var createAnonEndpointResp = await AuthApi.createAnonAccount();
      accessToken = createAnonEndpointResp["body"].accessToken;

    }
  }

  return accessToken;

}


// checks if the JWT is valid (not expired)
bool checkIfTokenValid(String accessToken) {
  var isValid = false;
  // decodes jwt to get just payload & convert into json
  final decodedAccessToken = json.decode(decodeBase64(accessToken.split(".")[1]));
  // fetches expiration
  var expiration = decodedAccessToken["exp"];
  // must multiply by 1000 to get to proper format
  expiration = expiration * 1000;
  // converts epoch time to DateTime
  final expirationDate = DateTime.fromMillisecondsSinceEpoch(expiration);
  // gets time now
  final timeNow = DateTime.now();

  // function returns 1 if the date is still valid
  final comparedTime = expirationDate.compareTo(timeNow);
  print("compared time is " + comparedTime.toString());

  // set true if valid
  if (comparedTime > 0) {
    isValid = true;
  }

  return isValid;
}

// get the userId from the access token
String getUserIdFromAccessToken(String accessToken) {
  var userId = "";
  // decodes jwt to get just payload & convert into json
  final decodedAccessToken = json.decode(decodeBase64(accessToken.split(".")[1]));
  // fetches expiration
  userId = decodedAccessToken["userId"];

  return userId;
}

// function that decodes a JWT
String decodeBase64(String toDecode) {
  String res;
  try {
    while (toDecode.length * 6 % 8 != 0) {
      toDecode += "=";
    }
    res = utf8.decode(base64.decode(toDecode));
  } catch (error) {
    throw Exception("decodeBase64([toDecode=$toDecode]) \n\t\terror: $error");
  }
  return res;
}