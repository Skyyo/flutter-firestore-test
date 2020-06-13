import 'package:flutter/material.dart';
import 'package:flutterfirestoretest/features/languages/LanguagesProvider.dart';
import 'package:flutterfirestoretest/features/languages/LanguagesScreenArgs.dart';
import 'package:flutterfirestoretest/features/languages/LanguagesState.dart';
import 'package:provider/provider.dart';

class LanguagesScreen extends StatelessWidget {
  static const tag = '/LanguagesScreen';

  @override
  Widget build(BuildContext context) {
    final LanguagesScreenArgs args = ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider(
        create: (_) => LanguagesProvider(args.userId),
        child: Scaffold(
            appBar: AppBar(
              title: Text('Languages'),
            ),
            body: Consumer<LanguagesProvider>(
                builder: (context, provider, child) {
              // ignore: missing_return
              return () {
                switch (provider.state.runtimeType) {
                  case LanguagesLoading:
                    return Center(
                      child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue)),
                    );
                  case LanguagesNetworkError:
                    //TODO show error and allow retry
                    return Center(child: Text("network error"));
                  case LanguagesSuccess:
                    return ListView.builder(
                      itemCount: provider.languagesList.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(
                            provider.languagesList[index],
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          value: provider.isSelected(index),
                          onChanged: (newValue) {
                            provider.selectLanguage(index);
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                        );
                      },
                    );
                }
                {}
              }();
            })));
  }
}
