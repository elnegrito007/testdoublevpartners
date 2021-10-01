import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_place/google_place.dart';
import 'package:mydata/utils/crud_store.dart';
import 'package:mydata/utils/services_app.dart';

import 'app_screen.dart';
import 'modal_register.dart';

class Home_screen extends StatefulWidget {
  Home_screen();

  @override
  _Home_screenState createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  _Home_screenState();

  String nombre="",apellido="",fecha="";
  List<String> listado=[];
  List<AutocompletePrediction> predictions = [];
  GooglePlace googlePlace;

  void extractDatos() async{
    String exist = await Store.gets("string", "active");
    if(exist!=""){
      List<String> info = await Store.gets("list", "info_"+exist);
      setState(() {
        nombre = info[0];
        apellido = info[1];
        fecha = info[2].substring(0,10);
      });
    }
  }

  void listDirsAll() async{
    List<String> info = await listDirs();
    setState(() {
      listado = info;
    });
  }

  @override
  void initState() {
    super.initState();
    googlePlace = GooglePlace("AIzaSyAvUnUXH-HJLR_JIgDHtfonWe-m_hdIGY0");
    extractDatos();
    listDirsAll();
  }

  void autoCompleteSearch(String value) async {
    try {
      var result = await googlePlace.autocomplete.get(value);
      if (result != null && result.predictions != null && mounted) {
        setState(() {
          predictions = result.predictions;
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {

    var ListadoWidget = List<Widget>();
    for (var iten in listado) {
      ListadoWidget.add(
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width / 1.1,
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(12),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(iten, textAlign: TextAlign.center)
                ],
              )
            ),
          )
        )
      );
    }

    return Material(
      child: Container(
        color: Theme.of(context).accentColor,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 13),
              height: 100,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Card(
                  color: Theme.of(context).backgroundColor,
                  elevation: 5,
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 9),
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    child: Text(nombre,style: TextStyle(fontSize: 20),),
                                  ),
                                  Container(
                                    child: Text(apellido,style: TextStyle(fontSize: 20),),
                                  )
                                ],
                              )
                          ),
                          Container(
                              child: Container(
                                child: Text(fecha,style: TextStyle(fontSize: 20),),
                              )
                          )
                        ],
                      )
                  )
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.12,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height < 629 ? 14 : 6,bottom: MediaQuery.of(context).size.height < 629 ? 18 : 2),
              child:FadeInLeft(
                  child: InkWell(
                    onTap: () async{
                      SystemChannels.platform
                          .invokeMethod<void>('SystemNavigator.pop');
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
                            AppLocalizations.of(context).translate('17'),
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
            Container(
              child: Column(
                children: ListadoWidget,
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 13),
                child: Column(
                  children: [
                    Container(
                      child: Container(
                          width: MediaQuery.of(context).size.width / 1.12,
                          margin: EdgeInsets.only(bottom: 2, top: 5),
                          child:TextField(
                            onChanged: (v){
                              autoCompleteSearch(v);
                            },
                            inputFormatters: [
                              WhitelistingTextInputFormatter(RegExp('[A-Za-z0-9 ]+')),
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
                              labelText: AppLocalizations.of(context).translate('14'),
                              labelStyle: TextStyle(color: Theme.of(context).backgroundColor),
                              hintStyle: TextStyle(color: Theme.of(context).backgroundColor),
                              prefixIcon: Icon(Icons.location_on_rounded, color: Theme.of(context).backgroundColor,),
                            ),
                            controller: lastname,
                          )
                      ),
                    ),
                    Container(
                      height: 400,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: ListView.builder(
                        padding:
                        EdgeInsets.only(top: 3.0),
                        itemCount: predictions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            dense: true,
                            leading: Icon(Icons.location_on_rounded,color: Theme.of(context).backgroundColor, size: 23,),
                            title: Text(
                              predictions[index].description,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).backgroundColor),
                            ),
                            onTap: () async{
                              await addAddress(predictions[index].description, context);
                              predictions=[];
                              listDirsAll();
                              FocusScope.of(this.context).unfocus();
                            },
                          );
                        },
                      ),
                    )
                  ],
                )
            ),
          ]),
        )
      ),
    );
  }
}
