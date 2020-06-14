import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirestoretest/features/main/AppProvider.dart';
import 'package:provider/provider.dart';

class StateFullSwitch extends StatefulWidget {
  @override
  _StateFullSwitchState createState() => _StateFullSwitchState();
}

class _StateFullSwitchState extends State<StateFullSwitch> {

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      trackColor: Colors.blue,
      value: Provider.of<AppProvider>(context, listen: false).isDarkModeOn,
      onChanged: (newValue) {
        setState(() {
          Provider.of<AppProvider>(context, listen: false).changeTheme();
        });
      },
      activeColor: Colors.green,
    );
  }

}
