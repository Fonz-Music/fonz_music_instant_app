import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fonz_music_flutter/ApiFunctions/UserTopArtistsResponse.dart';
import 'package:fonz_music_flutter/ApiFunctions/UserTopTracksResponse.dart';
import 'package:fonz_music_flutter/GlobalComponents/ExceptionHandling.dart';
import '../ApiConstants.dart';
import '../AuthMethods.dart';
// import 'package:http/http.dart' as http;

class SpotifySuggestionsApi {
  // --------------------------------------------now dio---------------------------------------------------------

  static Future<Map> getGuestTopSongs(String sessionId) async {
    log("Session id " + sessionId);
    String endpoint =
        address + guest + sessionId + '/' + spotify + search + "top?type=tracks";
    log(endpoint);
    // fetch token
    String token = await getJWTAndCheckIfExpired();

    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    log("about to get resp inside get top songs");
    try {
      var response = await dio.get(endpoint);
      log("top songs mate: " + response.data.toString());
      log("success");
      return {
        "statusCode": response.statusCode,
        "message":
        // response.body};
        response.statusMessage,
        "body": response.data
      };
    } on DioError catch (e) {
      log("issue " + e.response.data);
      log("dailure");
      return {
        "statusCode": e.response.data["status"],
        "code": e.response.data["code"],
        "body": e.response.data["body"]
      };
    }
  }
}


