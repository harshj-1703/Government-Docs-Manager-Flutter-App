import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:government_docs_manager_app/qrScreen.dart';
import 'package:government_docs_manager_app/websiteScreen.dart';
import "./welcomeScreen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Government Docs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      Future<void> _showMyDialog() async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('No Internet Connection'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('Please Connect To The Internet!'),
                    // Text('Would you like to approve of this message?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            );
          },
        );
      }

      _showMyDialog();
    }
  }

  @override
  void initState() {
    super.initState();
    checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Government Docs Manager"),
          backgroundColor: Color.fromARGB(255, 0, 96, 192),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 146, 189, 232),
                Color.fromARGB(255, 0, 96, 192),
                Color.fromARGB(255, 0, 76, 153),
                Color.fromARGB(255, 0, 96, 192),
                Color.fromARGB(255, 146, 189, 232),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebSiteScreen()),
                            );
                          },
                          child: Icon(
                            Icons.login,
                            color: Colors.white,
                            size: 50,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.cyan,
                            foregroundColor: Colors.cyan,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "User Login",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const QrScreen(),
                            ));
                          },
                          child: Icon(
                            Icons.qr_code,
                            color: Colors.white,
                            size: 50,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.cyan,
                            foregroundColor: Colors.cyan,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Verify Document",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ));
  }
}
