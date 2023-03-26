import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {

  static Future<bool?> success(String message){
    return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.tealAccent[100],
    textColor: Colors.black54,
    fontSize: 16.0,
    );
  }

  static Future<bool?> error(String message){
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.redAccent[100],
      textColor: Colors.black54,
      fontSize: 16.0,
    );
  }
}