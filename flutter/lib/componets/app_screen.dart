import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mydata/componets/splash_screen.dart';

import 'home_screen.dart';
import 'login_screen.dart';


Color getColorFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF' + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['es', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();
  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString = "";
    if (locale.languageCode == "es") {
      jsonString ='{"1":"Registrado","2":"Nombre de usuario","3":"Contraseña de usuario","4":"Nombres","5":"Apellidos","6":"Ya existe este usuario registrado","7":"Fecha de nacimiento","8":"Nombre de usuario","9":"Contraseña de usuario","10":"Datos invalidos","11":"Verificar","12":"En caso de no tener cuenta, ni conexión a internet, puedes crear tu cuenta en el siguiente boton","13":"Crear cuenta","14":"Dirección","15":"Cansad@ de olvidar direcciones? Cansad@ de tener direcciónes en todas partes? Te soluciono ya! Gracias esta app para guardar direcciónes favoritas y consultar cuando quieras","16":"Acceso","17":"Cerrar sesion"}';
    } else {
      jsonString ='{"1": "Registered", "2": "User name", "3": "User password", "4": "First name", "5": "Last name", "6": "This registered user already exists", "7": "Date of birth", "8": "User name", "9": "User password", "10": "Invalid data", "11": "Verify", "12": "If you do not have an account or internet connection, you can create your account by clicking on the following button", "13": "Create account", "14": "Address", "15": "Tired of forgetting addresses? Tired of having addresses everywhere? I solve it now! Thanks to this app to save your favorite addresses and consult them whenever you want.", "16": "Access","17":"Logout"}';
    }
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key];
  }
}

class App extends StatefulWidget {
  App();

  @override
  _AppState createState() => _AppState();

}

class _AppState extends State<App> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', 'US'),
          Locale('es', 'ES'),
        ],
        theme: ThemeData(
          fontFamily: 'Poppins',
          brightness: Brightness.light,
          primarySwatch: Colors.pink,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.black45,
          backgroundColor: Colors.white,
        ),
        darkTheme: ThemeData(
          fontFamily: 'Poppins',
          brightness: Brightness.dark,
          primarySwatch: Colors.pink,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.grey[50],
          backgroundColor: Colors.black45,
        ),
        debugShowCheckedModeBanner: false,
        title: 'My data app',
        initialRoute: 'splash',
        routes: {
          'splash': (BuildContext context) => Splash_screen(),
          'login': (BuildContext context) => Login_screen(),
          'home': (BuildContext context) => Home_screen(),
        }
    );
  }
}
