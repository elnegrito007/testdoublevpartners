
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mydata/utils/services_app.dart';
import 'package:toast/toast.dart';

import 'app_screen.dart';

TextEditingController user = TextEditingController();
TextEditingController pass = TextEditingController();
TextEditingController firstname = TextEditingController();
TextEditingController lastname = TextEditingController();

var now =  new DateTime.now();
var formatterAno =  new DateFormat("y");

void createAccount(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        child: new Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width / 1.6,
                    margin: EdgeInsets.only(bottom: 2, top: 40),
                    child:TextField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp('[A-Za-z0-9]+')),
                      ],
                      style: TextStyle(color: Theme.of(context).accentColor),
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).accentColor)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor),
                        ),
                        labelText: AppLocalizations.of(context).translate('2'),
                        labelStyle: TextStyle(color: Theme.of(context).accentColor),
                        hintStyle: TextStyle(color: Theme.of(context).accentColor),
                        prefixIcon: Icon(Icons.account_box_sharp, color: Theme.of(context).accentColor,),
                      ),
                      controller: user,
                    )
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.6,
                    margin: EdgeInsets.only(bottom: 2, top: 5),
                    child:TextField(
                      obscureText: true,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp('[A-Za-z0-9]+')),
                      ],
                      style: TextStyle(color: Theme.of(context).accentColor),
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).accentColor)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor),
                        ),
                        labelText: AppLocalizations.of(context).translate('3'),
                        labelStyle: TextStyle(color: Theme.of(context).accentColor),
                        hintStyle: TextStyle(color: Theme.of(context).accentColor),
                        prefixIcon: Icon(Icons.lock, color: Theme.of(context).accentColor,),
                      ),
                      controller: pass,
                    )
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.6,
                    margin: EdgeInsets.only(bottom: 2, top: 5),
                    child:TextField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp('[A-Za-z0-9 ]+')),
                      ],
                      style: TextStyle(color: Theme.of(context).accentColor),
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).accentColor)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor),
                        ),
                        labelText: AppLocalizations.of(context).translate('4'),
                        labelStyle: TextStyle(color: Theme.of(context).accentColor),
                        hintStyle: TextStyle(color: Theme.of(context).accentColor),
                        prefixIcon: Icon(Icons.supervised_user_circle, color: Theme.of(context).accentColor,),
                      ),
                      controller: firstname,
                    )
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.6,
                    margin: EdgeInsets.only(bottom: 2, top: 5),
                    child:TextField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp('[A-Za-z0-9 ]+')),
                      ],
                      style: TextStyle(color: Theme.of(context).accentColor),
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Theme.of(context).accentColor)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).accentColor),
                        ),
                        labelText: AppLocalizations.of(context).translate('5'),
                        labelStyle: TextStyle(color: Theme.of(context).accentColor),
                        hintStyle: TextStyle(color: Theme.of(context).accentColor),
                        prefixIcon: Icon(Icons.supervised_user_circle, color: Theme.of(context).accentColor,),
                      ),
                      controller: lastname,
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: 18),
                  child: InkWell(
                    onTap: () async{
                      final DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime(int.parse(formatterAno.format(now))-99),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(int.parse(formatterAno.format(now))-18),
                      );
                      if (picked != null && user.text!="" && pass.text!="" && firstname.text!="" && lastname.text!=""){
                        bool result = await procesarRegistro(picked,user.text,pass.text,firstname.text,lastname.text);
                        if (!result){
                          Toast.show(AppLocalizations.of(context).translate('6'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                        }else{
                          user.text="";
                          pass.text="";
                          firstname.text="";
                          lastname.text="";
                          Navigator.pushNamed(context, 'home');
                        }
                      }
                    },
                    child: Text(AppLocalizations.of(context).translate('7')),
                  ),
                )
              ],
            ),
          )
        )
      );
    },
  );
}
