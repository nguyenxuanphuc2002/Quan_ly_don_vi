import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testcheckinternet/main.dart';

class Check extends State<HomePage> {
  StreamSubscription? internetconnection;
  bool isoffline = false;

  //set variable for Connectivity subscription listiner
  @override
  void initState() {
    super.initState();
    internetconnection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }
    }); // using this listiner, you can get the medium of connection as well.

    super.initState();
  }

  @override
  dispose() {
    super.dispose();
    //internetconnection!.cancel();
    //cancel internent connection subscription after you are done
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: errmsg(
            "Không kết nối internet! Vui lòng kiểm tra lại mạng!",
            isoffline),
        height: 150,
        width: 220,
        margin: EdgeInsets.only(top: 400),
        //to show internet connection message on isoffline = true.
      ),
    );
  }
  Widget errmsg(String text, bool show) {
    //error message widget.
    if (show == true) {
      //if error is true then show error message box
      return Container(
        padding: EdgeInsets.all(10.00),
        margin: EdgeInsets.only(bottom: 10.00),
        color: Colors.red,
        child: Row(children: [
          Container(
            margin: EdgeInsets.only(right: 6.00),
            child: Icon(Icons.info, color: Colors.white),
          ), // icon for error message
          Container(
            child: Text(text,
                overflow: TextOverflow.clip,
                style: TextStyle(color: Colors.white)),
            width: 160,
          ),
          //show error message text
        ]),
      );
    } else {
      return Container();
    }
  }
}
