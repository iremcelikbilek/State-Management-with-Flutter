import 'dart:io';

import 'package:contact_with_provider/database/database_helper.dart';
import 'package:contact_with_provider/models/kullanici.dart';
import 'package:contact_with_provider/utils/format_photo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddContactPage extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  String kullaniciAd, kullaniciSoyad, kullaniciTelefon, kullaniciEmail, kullaniciIliski, kullaniciMeslek, kullaniciResim;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Düzenleme"),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          if(formKey.currentState.validate()){
            formKey.currentState.save();
            Provider.of<DatabaseHelper>(context,listen: false).kullaniciEkle(Kullanici(kullaniciAd,kullaniciSoyad,kullaniciTelefon,
            kullaniciEmail,kullaniciResim,kullaniciIliski,kullaniciMeslek)).then((value){
              if(value != 0){
                Navigator.of(context).pop();
              }
            });
          }

        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Consumer<FormatPhoto>(
              builder: (context, formatPhoto, child){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                        (kullaniciResim == null)
                            ? AssetImage("assets/images/profil_icon.png")  // contact ekleme ilk defa açıldığında gelen default değer
                            : formatPhoto.imageFromBase64String(kullaniciResim), // getImage() çağrıldığında gelen değer
                      ),

                      IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.photo,color: Colors.deepPurple,),
                          onPressed: (){
                            ImagePicker().getImage(source: ImageSource.gallery).then((pickedFile){
                              File imgFile = File(pickedFile.path);
                              kullaniciResim = formatPhoto.base64String(imgFile.readAsBytesSync());
                            });
                          }
                      ),
                    ],
                  ),
                );
              },
            ),

            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (text){
                        if(text.length <= 0)
                          return "Lütfen adınızı giriniz.";
                      },
                      onSaved: (text){
                        kullaniciAd = text;
                      },
                      decoration: InputDecoration(
                        hintText: 'Ad giriniz',
                        labelText: 'Ad:',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (text){
                        if(text.length <= 0)
                          return "Lütfen soyadınızı giriniz.";
                      },
                      onSaved: (text){
                        kullaniciSoyad = text;
                      },
                      decoration: InputDecoration(
                        hintText: 'Soyad giriniz',
                        labelText: 'Soyad:',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (text){
                        if(text.length <= 0)
                          return "Lütfen telefon numaranızı giriniz.";
                      },
                      onSaved: (text){
                        kullaniciTelefon = text;
                      },
                      decoration: InputDecoration(
                        hintText: 'Telefon numaranızı giriniz',
                        labelText: 'Telefon No:',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (text){
                        kullaniciEmail = text;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email\'inizi giriniz',
                        labelText: 'Email:',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (text){
                        kullaniciIliski = text;
                      },
                      decoration: InputDecoration(
                        hintText: 'İlişkinizi giriniz',
                        labelText: 'İlişki:',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (text){
                        kullaniciMeslek = text;
                      },
                      decoration: InputDecoration(
                        hintText: 'Meslek giriniz',
                        labelText: 'Meslek:',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



