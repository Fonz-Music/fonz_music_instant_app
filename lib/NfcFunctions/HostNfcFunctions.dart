import 'dart:async';

import 'dart:developer';

import 'package:fonz_music_instant_app/GlobalComponents/ExceptionHandling.dart';


import 'package:nfc_in_flutter/nfc_in_flutter.dart';





// Host class contains the static methods for writing to the coaster
class HostNfcFunctions {

  // static var sessionId = HostApi.createSession();

  // Prompts the user to scan the coaster and returns the UID on completion,
  // otherwise it will throw an exception
  static Future<List> readCoasterUid() async {
    try {
      bool _isNFCSupported = await NFC.isNDEFSupported;
      NDEFMessage recordTapped;

      if (_isNFCSupported) {

        recordTapped = await _scanForUidOnAndroid();
        log("uid maybe? " + recordTapped.id);
        return [recordTapped.id.toUpperCase(), recordTapped.payload];
        // return recordTapped.id.toUpperCase();


      } else {
        // Indicates that the user's device doesn't support nfc
        log("nfc not supported");
        throw new NfcNotSupportedException();
      }
    } on NfcNotSupportedException catch (e, stacktrace) {
      await NfcNotSupportedException.report(stacktrace);
      return null;
    }
  }

  // Writes the needed information to the coaster
  static Future<bool> writeNFC(String uid) async {
    try {
      bool wroteSuccessfully = false;
      Stream<NDEFTag> _stream;
      // do you need this? since its always called in _grabCoasterUid() anyways
      bool _isNFCSupported = await NFC.isNDEFSupported;
      //

      if (_isNFCSupported) {
        log("nfc is suppoted");
        log("url is " + uid);
//        var _stream =

        var msg = await _buildMessage(uid);
        log("built msg");

        await NFC.writeNDEF(msg, once: true).first;
        _stream.listen((NDEFTag tag) {
          print("wrote to tag");
        });
        // var record = await _stream.first;
        // await NFC.writeNDEF(msg, message: 'Activating your Fonz Coaster!', once: true).first;
        wroteSuccessfully = true;
        log("uid is: " + uid);
//        log("uid is: " + uid);
        // will addCoaster on the page
//        await HostApi.addCoaster(uid);
      } else {
        log("nfc isnt suppoted");
        throw new NfcNotSupportedException();
      }
      return wroteSuccessfully;
    } on NfcNotSupportedException catch (e, stacktrace) {
      await NfcNotSupportedException.report(stacktrace);
    } on NoSessionIDException catch (e, stacktrace) {
      await NoSessionIDException.report(stacktrace);
    } on SessionIDCreationException catch (e, stacktrace) {
      await SessionIDCreationException.report(stacktrace);
    } catch (e, stacktrace) {
      await GenericException.report(e, stacktrace);
    }
  }

  static Future<NDEFMessage> _buildMessage(String uid) async {
    List<NDEFRecord> _records = [];
    // var plainUrl = "fonzmusic.com/" + uid;
    var fonzUrl = Uri.https("fonzmusic.com", uid);
    // var fonzUrl = "fonzmusic.com/" + uid;
    log("url is " + fonzUrl.toString());
    NDEFRecord url = new NDEFRecord.uri(fonzUrl);
    // NDEFRecord url = new NDEFRecord.plain(data)
    // log("ndef url is " + url.);
    _records.add(url);
    log("added rec hrer");
    return NDEFMessage.withRecords(_records);
  }

  static Future<void> updateNFC() async {
    bool _isNdefSupported = await NFC.isNDEFSupported;
  }

  // scanns for and checks for the uid on android
  static Future<NDEFMessage> _scanForUidOnAndroid() async {
    String coasterUid;
    Stream<NDEFMessage> _stream;

    _stream = NFC.readNDEF(alertMessage: 'Looking for a Fonz!', once: true);
    _stream.handleError((error) {
      if (error is NFCUserCanceledSessionException) {
        log("user canceled session ");
        Exception(error.toString());
      } else if (error is NFCSessionTimeoutException) {
        log("session time out");
        Exception(error.toString());
      } else {
        log("strange ");
        Exception(error.toString());
      }
      return null;
    });
    NDEFMessage record = await _stream.first;
    // i believe this is proper way to retrieve the uid from the library.
    // check docs otherwise:
    //
    coasterUid = record.id;
    log("the message is " + record.payload);
    log("uid from id " + record.id.toString());
    log("getting caught here");
    return record;
  }
}