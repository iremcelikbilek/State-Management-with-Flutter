import 'package:contact_list_scoped_model/database/database_helper.dart';
import 'package:contact_list_scoped_model/screens/contact_page.dart';
import 'package:contact_list_scoped_model/utils/format_photo.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple,
      accentColor: Colors.blueGrey,
    ),
    home: ScopedModel(
        model: DatabaseHelper(),
        child: ScopedModel(
          model: FormatPhoto(),
            child: ContactPage())),
  ));
}

