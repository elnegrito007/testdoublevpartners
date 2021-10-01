import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mydata/utils/services_app.dart';
import 'package:toast/toast.dart';

import 'app_screen.dart';
import 'modal_register.dart';

class Modal_login_screen extends StatefulWidget {
  Modal_login_screen();

  @override
  _Modal_login_screenState createState() => _Modal_login_screenState();
}

class _Modal_login_screenState extends State<Modal_login_screen> {

  _Modal_login_screenState();

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).accentColor,
        height: MediaQuery.of(context).size.height / 1.7,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(9),
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height < 629 ? 8 : 3, top: MediaQuery.of(context).size.height < 629 ? 23 : 13),
                          child:TextField(
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp('[A-Za-z0-9]+')),
                            ],
                            style: TextStyle(color: Theme.of(context).backgroundColor),
                            cursorColor: Theme.of(context).backgroundColor,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).backgroundColor)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).backgroundColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).backgroundColor),
                              ),
                              labelText: AppLocalizations.of(context).translate('8'),
                              labelStyle: TextStyle(color: Theme.of(context).backgroundColor),
                              hintStyle: TextStyle(color: Theme.of(context).backgroundColor),
                              prefixIcon: Icon(Icons.account_box_sharp, color: Theme.of(context).backgroundColor,),
                            ),
                            controller: user,
                          )
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          margin: EdgeInsets.only(bottom: 2, top: MediaQuery.of(context).size.height < 629 ? 5 : 2),
                          child:TextField(
                            obscureText: true,
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp('[A-Za-z0-9]+')),
                            ],
                            style: TextStyle(color: Theme.of(context).backgroundColor),
                            cursorColor: Theme.of(context).backgroundColor,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).backgroundColor)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).backgroundColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).backgroundColor),
                              ),
                              labelText: AppLocalizations.of(context).translate('9'),
                              labelStyle: TextStyle(color: Theme.of(context).backgroundColor),
                              hintStyle: TextStyle(color: Theme.of(context).backgroundColor),
                              prefixIcon: Icon(Icons.lock, color: Theme.of(context).backgroundColor,),
                            ),
                            controller: pass,
                          )
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height < 629 ? 14 : 6,bottom: 18),
                        child:FadeInRight(
                            child: InkWell(
                              onTap: () async{
                                if(user.text!="" && pass.text!="") {
                                  bool result = await loginApp(user.text, pass.text);
                                  if(!result){
                                    user.text="";
                                    pass.text="";
                                    Toast.show(AppLocalizations.of(context).translate('10'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                                  }else{
                                    user.text="";
                                    pass.text="";
                                    Navigator.pushNamed(context, 'home');
                                  }
                                }
                              },
                              child: Container(
                                child: Container(
                                  width: 230,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(17),
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context).translate('11'),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),
                      Divider(color: Theme.of(context).backgroundColor),
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height < 629 ? 12 : 5),
                        child: Text(AppLocalizations.of(context).translate('12'),textAlign: TextAlign.center, style: TextStyle(color:Theme.of(context).backgroundColor),)
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height < 629 ? 14 : 6,bottom: MediaQuery.of(context).size.height < 629 ? 18 : 2),
                        child:FadeInLeft(
                            child: InkWell(
                              onTap: () async{
                                createAccount(context);
                              },
                              child: Container(
                                child: Container(
                                  width: 230,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(17),
                                    color: Colors.redAccent,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context).translate('13'),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}