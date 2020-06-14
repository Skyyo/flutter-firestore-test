import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirestoretest/features/home/DrawerWidget.dart';
import 'package:flutterfirestoretest/features/main/AppProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const tag = '/HomeScreen';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        endDrawer: DrawerWidget(),
        body: Consumer<AppProvider>(builder: (context, provider, child) {
          if (provider.requestSnackbar) {
            provider.requestSnackbar = false;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.blue,
                  content:
                      Text("Signed with id ${provider.selectedFireStoreId}")));
            });
          }
          return SafeArea(
            child: Stack(
              children: <Widget>[
                Positioned(
                    right: 8,
                    top: 8,
                    child: IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        scaffoldKey.currentState.openEndDrawer();
                      },
                    )),
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 6.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          child: Text(
                            'Hello World',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                    )),
                Positioned(
                    bottom: 0,
                    right: 8,
                    left: 0,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text('Press the button to silent auth using id.',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              textAlign: TextAlign.center),
                          MaterialButton(
                              child: Text("auth with id 3"),
                              color: Colors.green,
                              onPressed: () {
                                saveId("3", context);
                              }),
                          MaterialButton(
                              child: Text("auth with id 2"),
                              color: Colors.green,
                              onPressed: () {
                                saveId("2", context);
                              }),
                          MaterialButton(
                              child: Text("auth with id 1"),
                              color: Colors.green,
                              onPressed: () {
                                saveId("1", context);
                              }),
                        ],
                      ),
                    ))
              ],
            ),
          );
        }));
  }

  Future<void> saveId(String id, BuildContext context) async {
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

    final _auth = FirebaseAuth.fromApp(app);
    final _result = await _auth.signInAnonymously();

    final Firestore firestore = Firestore(app: app);
    final userId =
        Provider.of<AppProvider>(context, listen: false).selectedFireStoreId;
    await firestore
        .collection("user$userId")
        .document("settings")
        .get()
        .then((value) {
      Provider.of<AppProvider>(context, listen: false)
          .saveFireStoreIdAndTheme(id, value.data["darkThemeOn"]);
    });
  }
}
