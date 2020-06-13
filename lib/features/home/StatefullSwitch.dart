import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirestoretest/features/main/AppProvider.dart';
import 'package:provider/provider.dart';

class StateFullSwitch extends StatefulWidget {
  @override
  _StateFullSwitchState createState() => _StateFullSwitchState();
}

class _StateFullSwitchState extends State<StateFullSwitch> {
  bool isDarkThemeOn = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      trackColor: Colors.blue,
      value: isDarkThemeOn,
      onChanged: (newValue) {
        setState(() {
          isDarkThemeOn = !isDarkThemeOn;
          Provider.of<AppProvider>(context,listen: false).changeTheme();
        });
      },
      activeColor: Colors.green,
    );
  }
}
