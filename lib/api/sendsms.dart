// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_external_app/flutter_external_app.dart';
import 'package:flutter_sms/flutter_sms.dart';

Future sendsms(
    {required String msg, required List<String> phoneNumbers}) async {
  String result =
      await sendSMS(message: msg, recipients: phoneNumbers, sendDirect: true)
          .catchError((onError) {
    print(onError);
    return "none";
  });
  print(result);
}

Future sendWAmsg(
    {required String msg, required List<String> phoneNumbers}) async {
  for (String phoneNo in phoneNumbers) {
    String url = "https://api.whatsapp.com/send?phone=$phoneNo&text=$msg}";
    String androidLink =
        'intent://send/$url#Intent;scheme=whatsapp;package=com.whatsapp;S.browser_fallback_url=https://play.google.com/store/apps/details?id=com.whatsapp.w4b;end';
    // String androidLink =
    //     'intent://send/$url#Intent;scheme=whatsapp;package=com.whatsapp;end';
    String iosLink = 'whatsapp://send?$url';
    // String androidLink =
    //     ''intent://payment#Intent;action=ch.twint.action.TWINT_UOF_REGISTRATION;scheme=twint;S.code=T23LU9K;S.startingOrigin=EXTERNAL_WEB_BROWSER;S.browser_fallback_url=;end';';
    // await launchUrl(Uri.parse(url)).then((value) => print(value));
    // String url = "https://api.whatsapp.com/send?phone=$phoneNo&text=$msg";

    if (Platform.isAndroid) {
      FlutterExternalApp.openApp(androidLink);
      // AndroidIntent intent = AndroidIntent(
      //     action: 'action_view',
      //     package: "com.whatsapp",
      //     // arguments: {'route': 'com.whatsapp.w4b:id/entry'},
      //     data: Uri.encodeFull(url));

      // await intent.launch();
    } else if (Platform.isIOS) {
      FlutterExternalApp.openApp(iosLink);
    }
  }
}
