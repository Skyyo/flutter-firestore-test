import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  bool isDarkModeOn = false;
  bool requestSnackbar = false;
  String selectedFireStoreId;

  final darkTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.grey,
    brightness: Brightness.light,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
  );

  void changeTheme() {
    isDarkModeOn = !isDarkModeOn;
    notifyListeners();
  }
  void saveFireStoreId(String id){
    selectedFireStoreId = id;
    requestSnackbar = true;
    notifyListeners();
  }
}
