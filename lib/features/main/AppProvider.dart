import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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

  Future<void> changeTheme() async {
    isDarkModeOn = !isDarkModeOn;
    final FirebaseApp app = await FirebaseApp.configure(
      name: 'Flutter-firestore-test',
      options: const FirebaseOptions(
        //TODO add ios identificatior
        googleAppID: '1:1045729913264:android:06de567b03b88c25cd8e75',
        gcmSenderID: '1045729913264',
        apiKey: 'AIzaSyB-CqK6u-RKidqOIqYRyBZCSrrKutYECU8',
        projectID: 'flutter-firestore-test-be1b0',
      ),
    );
    final Firestore firestore = Firestore(app: app);
    await firestore
        .collection("user$selectedFireStoreId")
        .document("settings")
        .updateData({'darkThemeOn': isDarkModeOn});
    notifyListeners();
  }

  void saveFireStoreIdAndTheme(String id, bool isDarkMode) {
    selectedFireStoreId = id;
    isDarkModeOn = isDarkMode;
    requestSnackbar = true;
    notifyListeners();
  }
}
