import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SnackBarUtils {
  static void showResult(GlobalKey<ScaffoldState> scaffoldKey, String text) {
    if (scaffoldKey.currentState != null) {
      ScaffoldMessenger.maybeOf(scaffoldKey.currentContext!)!.showSnackBar(
          SnackBar(duration: const Duration(seconds: 1), content: Text(text,style: const TextStyle(color: Colors.black),)));
    } else {
      print(text);
    }
  }

  static void showMsg(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
