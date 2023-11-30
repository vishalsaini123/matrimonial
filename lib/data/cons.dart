import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Cons {
  static const String defaultFontFamily = "montserrat";
  static const String host = "bcardon";
  static const String marker = "372857";
  static const String token = "3e7648ea9c0dbe7ce5b52d91ebc05dbc";
  static const String imageBaseUrl = "https://enigmamotions.com/uploads/";

  static DateFormat sqlFormat = DateFormat('yyyy-MM-dd');
  static DateFormat readableFormat = DateFormat('EEEE, dd MMM yyyy');
  static DateFormat defaultFormat = DateFormat('dd MMM yyyy');
  static DateFormat dayMonthFormat = DateFormat('dd MMM');

  static String minutesToHHMM(int? mins) {
    if (null != mins) {
      return "${mins ~/ 60}h  ${mins % 60}m";
    }
    return "";
  }

  static String generateMd5(String data) {
    return md5.convert(utf8.encode(data)).toString();
  }


  static Future<void> launchUrl(String url) async {
    if (!await launchUrlString(url)) {
      throw 'Could not launch $url';
    }
  }
}
