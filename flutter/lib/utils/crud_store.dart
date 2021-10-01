import 'package:shared_preferences/shared_preferences.dart';

class Store {

  static SharedPreferences store;

  static sets(String type, String key, value) async {
    store = await SharedPreferences.getInstance();
    switch (type) {
      case 'bool':
        store.setBool(key, value);
        break;
      case 'string':
        store.setString(key, value);
        break;
      case 'list':
        store.setStringList(key, value);
        break;
      case 'int':
        store.setInt(key, value);
        break;
      case 'double':
        store.setDouble(key, value);
        break;
      case 'del':
        store.remove(key);
        break;
      default:
    }
  }

  static gets(String type, String key) async {
    store = await SharedPreferences.getInstance();
    var value;
    switch (type) {
      case 'bool':
        if (store.getBool(key) == null) {
          store.setBool(key, false);
        }
        value = store.getBool(key) == null ? false : store.getBool(key);
        break;
      case 'string':
        if (store.getString(key) == null) {
          store.setString(key, '');
        }
        value = store.getString(key) == null ? '' : store.getString(key);
        break;
      case 'list':
        if (store.getStringList(key) == null) {
          store.setStringList(key, []);
        }
        value =
            store.getStringList(key) == null ? [] : store.getStringList(key);
    break;
    case 'int':
    if (store.getInt(key) == null) {
    store.setInt(key, 0);
    }
    value = store.getInt(key) == null ? 0 : store.getInt(key);
    break;
    case 'double':
    if (store.getDouble(key) == null) {
    store.setDouble(key, 0.0);
    }
    value = store.getDouble(key) == null ? 0.0 : store.getDouble(key);
    break;
  }
    return value;
  }

  static dels(String key) async {
    store = await SharedPreferences.getInstance();
    store.remove(key);
  }

}