import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirestoretest/features/languages/LanguagesScreen.dart';
import 'package:flutterfirestoretest/features/languages/LanguagesScreenArgs.dart';
import 'package:flutterfirestoretest/features/main/AppProvider.dart';
import 'package:provider/provider.dart';

import 'StatefullSwitch.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
                title: Row(
                  children: <Widget>[
                    Text('Dark theme',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
                trailing: StateFullSwitch()),
            ListTile(
              title: Text('Language',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, LanguagesScreen.tag,
                    arguments: LanguagesScreenArgs(
                        userId: Provider.of<AppProvider>(context, listen: false)
                            .selectedFireStoreId));
              },
            ),
          ],
        ),
      ),
    );
  }
}
