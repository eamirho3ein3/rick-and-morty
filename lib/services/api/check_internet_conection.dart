import 'dart:io';

import 'package:flutter/foundation.dart';

Future<bool> checkInternetConenction() async {
  if (kIsWeb) {
    return true;
  } else {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      print("error in lookup is $e ");
      return false;
    }
  }
}
