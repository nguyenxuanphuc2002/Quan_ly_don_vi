import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Quản Lý Đơn Vị';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  //final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      //appBar: AppBar(
      //backgroundColor: Color.fromARGB(255, 194, 46, 46),
      //title: Text("Quản lý đơn vị")),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  decoration:
                      new BoxDecoration(color: Color.fromARGB(255, 88, 91, 88)),
                  height: 810,
                  width: 150,
                  // const IconButton(
                  //   icon: Icon(Icons.menu),
                  //   tooltip: 'Menu',
                  //   onPressed: null, // null disables the button
                  // ),
                  child: Column(
                    children: [
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.menu),
                          tooltip: 'Menu',
                          onPressed: null,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.people),
                          Text('Quân số'),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
          Container(
            decoration:
                new BoxDecoration(color: Color.fromARGB(255, 255, 174, 174)),
            width: 1150,
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.search_sharp),
                            Text('  Tình trạng'),
                          ],
                        ),
                        margin: EdgeInsets.all(15),
                        color: Colors.pink,
                        padding: EdgeInsets.all(15),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.people_alt),
                            Text('  DS Giáo viên'),
                          ],
                        ),
                        margin: EdgeInsets.all(15),
                        color: Color.fromARGB(255, 30, 233, 233),
                        padding: EdgeInsets.all(15),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.person_pin_rounded),
                            Text('  Quân số Hội, Họp'),
                          ],
                        ),
                        margin: EdgeInsets.all(15),
                        color: Color.fromARGB(255, 2, 250, 52),
                        padding: EdgeInsets.all(15),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month),
                            Text('  Lịch lên lớp'),
                          ],
                        ),
                        margin: EdgeInsets.all(15),
                        color: Color.fromARGB(255, 229, 251, 28),
                        padding: EdgeInsets.all(15),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today),
                            Text('  Lịch làm việc'),
                          ],
                        ),
                        margin: EdgeInsets.all(15),
                        color: Color.fromARGB(255, 0, 136, 255),
                        padding: EdgeInsets.all(15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration:
                new BoxDecoration(color: Color.fromARGB(255, 255, 174, 174)),
            width: 236,
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Text('Xem lịch làm việc'),
                  ),
                  decoration: new BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255)),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
                  width: 150,
                ),
                Container(
                  child: Center(
                    child: Text('Báo cáo công việc'),
                  ),
                  decoration: new BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255)),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: 150,
                ),
                Container(
                  child: errmsg(
                      "Không kết nối internet! Vui lòng kiểm tra lại mạng!",
                      isoffline),
                  height: 150,
                  width: 220,
                  margin: EdgeInsets.only(top: 400),
                  //to show internet connection message on isoffline = true.
                ),
              ],
            ),
          ),
        ],
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
      // return AlertDialog(
      //   title: const Text('AlertDialog Title'),
      //   content: const Text('AlertDialog description'),
      //   actions: <Widget>[
      //     TextButton(
      //       onPressed: () => Navigator.pop(context, 'Cancel'),
      //       child: const Text('Cancel'),
      //     ),
      //     TextButton(
      //       onPressed: () => Navigator.pop(context, 'OK'),
      //       child: const Text('OK'),
      //     ),
      //   ],
      // );
      // return Container(
      //   padding: EdgeInsets.all(10.00),
      //   margin: EdgeInsets.only(bottom: 10.00),
      //   color: Colors.blue,
      //   child: Row(children: [
      //     Container(
      //       margin: EdgeInsets.only(right: 6.00),
      //       child: Icon(Icons.check_box, color: Colors.white),
      //     ), // icon for error message
      //     Text('Đã kết nối internet',
      //         textAlign: TextAlign.center,
      //         overflow: TextOverflow.clip,
      //         style: TextStyle(color: Colors.white)),
      //     //show error message text
      //   ]),
      // );
      //if error is false, return empty container.
    }
  }
}
