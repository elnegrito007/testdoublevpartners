import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'app_screen.dart';
import 'modal_login.dart';

class Login_screen extends StatefulWidget {
  Login_screen();

  @override
  _Login_screenState createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  _Login_screenState();


  Future<bool> modal_login(BuildContext context) async {

    showCupertinoModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: false,
        duration: Duration(milliseconds: 600),
        builder: (context) => Modal_login_screen()
    );

    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(new Duration(microseconds: 500), () async {
      modal_login(this.context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Container(
        child:SingleChildScrollView(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height < 629 ? 26 : 14),
                      child: Bounce(
                        child:Icon(Icons.my_location_rounded, color: Colors.redAccent,size: 34),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      child:FadeIn(child: Text(
                        "My datApp",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height < 629 ? 70 : 60 ,
                            fontFamily: "Kiss",
                            color: Theme.of(context).accentColor
                        ),
                      ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height < 629 ? 7: 2),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Text(AppLocalizations.of(context).translate('15'),textAlign: TextAlign.center,)
                    ),
                    Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height < 629 ? 7 : 2),
                        child: Text(AppLocalizations.of(context).translate('16'), style: TextStyle(fontFamily: "Poppins"),)
                    )
                  ],
                )
              ]
          ),
        )
      ),
    );
  }
}