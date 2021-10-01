import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash_screen extends StatefulWidget {
  Splash_screen();

  @override
  _Splash_screenState createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  _Splash_screenState();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5),() async {
      Navigator.pushNamed(this.context, 'login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Container(
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: <Widget>[
                          Bounce(
                            child:Icon(Icons.my_location_rounded, color: Colors.redAccent,size: 34),
                          ),
                          FadeIn(child: Text(
                            "My datApp",
                            style: TextStyle(
                                fontSize: 70,
                                fontFamily: "Kiss",
                                color: Theme.of(context).accentColor
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ]
            )
          ),
        ),
      ),
    );
  }
}