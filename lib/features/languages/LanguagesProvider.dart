import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirestoretest/features/languages/LanguagesState.dart';

class LanguagesProvider with ChangeNotifier {
  String userId = "English";
  String selectedLanguage = "English";
  List<String> languagesList;
  LanguagesState state = LanguagesState.loading;

  LanguagesProvider(String id) {
    userId = id;
    fetchLanguages();
    getFirestoreSettings();
  }

  Future<void> getFirestoreSettings() async {
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
    firestore
        .collection("user$userId")
        .document("settings")
        .get()
        .then((value) {
      selectedLanguage = value.data["selectedLanguage"];
      print("vovk $selectedLanguage");
      notifyListeners();
    });
  }

  Future<void> selectLanguage(int index) async {
    selectedLanguage = languagesList[index];
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
    firestore
        .collection("user$userId")
        .document("settings")
        .updateData({'selectedLanguage': selectedLanguage});
    notifyListeners();
  }

  bool isSelected(int index) {
    return selectedLanguage == languagesList[index];
  }

  Future fetchLanguages() async {
    state = LanguagesState.loading;
    notifyListeners();
    try {
      Response response = await Dio().get("http://165.22.19.126:4000/");
      final languages = response.data['languages'];
      if (languages != null) {
        languagesList = (languages as List).map((i) => i.toString()).toList();
        state = LanguagesState.success;
      }
    } catch (error) {
      state = LanguagesState.noNetwork;
    }
    notifyListeners();
  }
}
