import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fonz_music_instant_app/GlobalComponents/ExceptionHandling.dart';
import '../ApiConstants.dart';
import '../AuthMethods.dart';
// import 'package:http/http.dart' as http;


class GuestSpotifyApi {
  // --------------------------------------------now dio---------------------------------------------------------

  static Future<Map> sessionSearch(String sessionId, String term) async {
    log("Session id " + sessionId);
    String endpoint =
        address + guest + sessionId + '/' + spotify + searchTerm + term;
    log(endpoint);
    // fetch token
    String token = await getJWTAndCheckIfExpired();
    // await FirebaseAuth.instance.currentUser.getIdToken();

    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    log("about to get resp inside sessopnSearch");
    try {
      var response = await dio.get(endpoint);
      log(response.data.toString());
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

  // --------------------------------------------now dio---------------------------------------------------------

  static Future<Map> queueTrackSpotify(String trackId, String sessionId) async {
    // fetch token
    String token = await getJWTAndCheckIfExpired();
    var endpoint = address +
        guest +
        sessionId +
        '/' +
        spotify +
        queue +
        'spotify:track:$trackId';
    log(endpoint);
    var returnToUser;
//    dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    try {
      var response = await dio.post(endpoint);
      // http
      // return await http.post(endpoint, headers: {
      //   HttpHeaders.authorizationHeader: "Bearer $token",
      // });
      if (response.statusCode == 200) {
        log("success");
        return {
          "statusCode": response.statusCode,
          "message": response.statusMessage,
          "body": response.data
        };
      } else {
        log("not 200");
        return {
          "statusCode": response.statusCode,
          "message": response.statusMessage,
          "body": response.data
        };
      }
    } on DioError catch (e) {
      return {
        "statusCode": e.response.data["status"],
        "code": e.response.data["code"],
        "body": e.response.data["body"]
      };
    }

    return returnToUser;
  }

  static Future<Map> fetchActiveSong(String sessionId) async {
    log("Session id " + sessionId);
    String endpoint =
        address + guest + sessionId + '/' + spotify + "state";
    log(endpoint);
    // fetch token
    String token = await getJWTAndCheckIfExpired();
    // await FirebaseAuth.instance.currentUser.getIdToken();

    // dio
    Dio dio = new Dio();
    dio.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    log("about to get resp inside active song");
    try {
      var response = await dio.get(endpoint);
      log(response.data.toString());
      if (response.statusCode == 200 ) {
        log("success");
        final activeSongDecoded = ActiveSongDecoder.fromJson(response.data);
        log("images is " + activeSongDecoded.images[0]["url"].toString());
        response.data = activeSongDecoded;

      }

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

//
//   static Future<UserTopArtistsResponse> getUserTopArtists() async {
//     Dio dio = new Dio();
//     try {
//       dio.options.headers = {
//         HttpHeaders.authorizationHeader: 'Bearer $token',
//       };
//       Response response =
//           await dio.get('https://api.spotify.com/v1/me/top/artists');
//       if (response.statusCode == 200) {
//         UserTopArtistsResponse.fromJson(json.decode(response.data.toString()));
//       } else {
//         log(response.statusCode.toString());
//         log(response.statusMessage);
//         log(response.data.toString());
//         throw new SpotifyException(SpotifyExceptionTypes.ARTISTS);
//       }
//     } on SpotifyException catch (e) {
//       rethrow;
//     }
//   }
//
//   static Future<UserTopTracksResponse> getUserTopTracks() async {
//     Dio dio = new Dio();
//     dio.options.headers = {
//       HttpHeaders.authorizationHeader: 'Bearer $token',
//     };
//     try {
//       Response response =
//           await dio.get('https://api.spotify.com/v1/me/top/tracks');
//       if (response.statusCode == 200) {
//         UserTopTracksResponse.fromJson(json.decode(response.data.toString()));
//       } else {
//         log(response.statusCode.toString());
//         log(response.statusMessage);
//         log(response.data.toString());
//         throw new SpotifyException(SpotifyExceptionTypes.TRACKS);
//       }
//     } on SpotifyException catch (e) {
//       rethrow;
//     }
//   }
}


// create anon account decoder
class ActiveSongDecoder {
  String artistName;
  String trackName;
  List images;

  ActiveSongDecoder({this.artistName, this.trackName, this.images});
  // ActiveSongDecoder({this.artistName, this.trackName});

  ActiveSongDecoder.fromJson(Map<String, dynamic> json) {
    artistName = json['artistName'];
    trackName = json['trackName'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artistName'] = this.artistName;
    data['trackName'] = this.trackName;
    data['images'] = this.images;
    return data;
  }
}
//
// // create anon account decoder
// class ImageActiveSongDecoder {
//   ImageUrlActiveSongDecoder images;
//   // String trackName;
//   // Images images;
//
//   // ActiveSongDecoder({this.artistName, this.trackName, this.images});
//   ImageActiveSongDecoder({this.images});
//
//   ImageActiveSongDecoder.fromJson(Map<String, dynamic> json) {
//     images = ImageUrlActiveSongDecoder.fromJson(json['images']);
//     // trackName = json['trackName'];
//     // images = Images.fromJson(json['images']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     // data['trackName'] = this.trackName;
//     // data['images'] = this.images;
//     return data;
//   }
// }


// create anon account decoder
class ImageUrlActiveSongDecoder {
  String url;
  // String trackName;
  // Images images;

  // ActiveSongDecoder({this.artistName, this.trackName, this.images});
  ImageUrlActiveSongDecoder({this.url});

  ImageUrlActiveSongDecoder.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    // trackName = json['trackName'];
    // images = Images.fromJson(json['images']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    // data['trackName'] = this.trackName;
    // data['images'] = this.images;
    return data;
  }
}

