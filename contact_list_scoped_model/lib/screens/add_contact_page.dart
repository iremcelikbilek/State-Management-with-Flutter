import 'dart:io';

import 'package:contact_list_scoped_model/database/database_helper.dart';
import 'package:contact_list_scoped_model/models/kullanici.dart';
import 'package:contact_list_scoped_model/utils/format_photo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';


class AddContactPage extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  String kullaniciAd, kullaniciSoyad, kullaniciTelefon, kullaniciEmail, kullaniciIliski, kullaniciMeslek, kullaniciResim,message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Düzenleme"),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          if(formKey.currentState.validate()){
            formKey.currentState.save();
            ScopedModel.of<DatabaseHelper>(context).kullaniciEkle(Kullanici(kullaniciAd,kullaniciSoyad,kullaniciTelefon,
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
            ScopedModelDescendant<FormatPhoto>(builder: (context,child,formatPhoto){
              debugPrint("Scoped Model format photo kısmı çalıştı");
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
            }),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (text){
                        if(text.length <= 0)
                          message = "Lütfen adınızı giriniz.";
                        return message;
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
                          message = "Lütfen soyadınızı giriniz.";
                        return message;
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
                          message = "Lütfen telefon numaranızı giriniz.";
                        return message;
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



