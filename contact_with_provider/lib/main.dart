import 'package:contact_with_provider/database/database_helper.dart';
import 'package:contact_with_provider/screens/contact_page.dart';
import 'package:contact_with_provider/utils/format_photo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple,
      accentColor: Colors.blueGrey,
    ),
    home: MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DatabaseHelper()),
        ChangeNotifierProvider.value(value: FormatPhoto()),
      ],
        child: ContactPage()),
  ));
}

